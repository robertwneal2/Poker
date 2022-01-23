require_relative "deck"
require_relative "card"

class Hand

    HAND_RANKS = ["high_card", "pair", "two_pair", 
                  "three_of_a_kind", "straight", 
                  "flush", "full_house", 
                  "four_of_a_kind", "straight_flush",
                  "royal_flush"]

    CARD_VALUES = {"2" => 2, "3" => 3, "4" => 4, "5" => 5,
                   "6" => 6, "7" => 7, "8" => 8, "9" => 9,
                   "10" => 10, "J" => 11, "Q" => 12,
                   "K" => 13, "A" => 14}

    def self.compare_hands(hands) #array input
        highest_rank = 0
        highest_rank_hands = []
        hands.each do |hand|
            hand_value = hand.hand_value?[0]
            if hand_value > highest_rank
                highest_rank = hand_value
                highest_rank_hands = [hand]
            elsif hand_value == 
                highest_rank = hand_value
                highest_rank_hands << hand
            end
        end
        return highest_rank_hands[0] if highest_rank_hands.length == 1
        #tie
        winning_hands = {}
        highest_rank_hands.each { |hand| winning_hands[hand] = true}
        tie_length = highest_rank_hands[0].hand_value?[1].length - 1
        (0..tie_length).each do |i|
            tie_val = 0
            winning_hands.each do |hand, still_in| #find max tie value
                if still_in == true
                    hand_tie_val = hand.hand_value?[1][i]
                    if hand_tie_val > tie_val
                        tie_val = hand_tie_val
                    end
                end
            end
            winning_hands.each do |hand, still_in| 
                if still_in == true
                    hand_tie_val = hand.hand_value?[1][i]
                    if hand_tie_val < tie_val
                        winning_hands[hand] = false
                    end
                end
            end
        end
        final_hands = []
        winning_hands.each do |hand, still_in|
            if still_in == true
                final_hands << hand
            end
        end
        final_hands
    end

    attr_reader :cards, :deck
    def initialize(deck)
        @deck = deck
        @cards = []
        5.times do
            @cards << @deck.remove
        end
    end

    def inspect
        values = []
        @cards.each do |card|
            val = card.val
            suit = card.suit
            values << [val, suit]
        end
        values
    end

    def remove(indices)
        temp_cards = []
        @cards.each_with_index do |card, index|
            if !indices.include?(index)
                temp_cards << card
            end
        end
        @cards = temp_cards
        add(indices.length)
    end

    def hand_value?
        if royal_flush? != false
            val = "royal_flush"
            tie = royal_flush?
        elsif straight_flush? != false
            val = "straight_flush"
            tie = straight_flush?
        elsif four_of_a_kind? != false
            val = "four_of_a_kind"
            tie = four_of_a_kind?
        elsif full_house? != false
            val = "full_house"
            tie = full_house?
        elsif flush? != false
            val = "flush" 
            tie = flush?
        elsif straight? != false
            val = "straight"
            tie = straight?
        elsif three_of_a_kind? != false
            val = "three_of_a_kind"
            tie = three_of_a_kind?
        elsif two_pair? != false
            val = "two_pair"
            tie = two_pair?
        elsif pair? != false
            val = "pair"
            tie = pair?
        else
            val = "high_card"
            tie = high_card
        end
        val_index = HAND_RANKS.index(val)
        return [val_index, tie]
    end

    private

    def add(num)
        num.times do
            @cards << @deck.remove
        end
    end

    def royal_flush?
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        if straight_flush? && values.max == 14
            return [14]
        end
        false
    end

    def straight_flush?
        if straight? != false && flush? != false
            return straight?
        end
        false
    end

    def four_of_a_kind?
        values = []
        quad = 0
        sing = 0
        @cards.each { |card| values << CARD_VALUES[card.val]}
        values.each do |val|
            if values.count(val) == 4
                quad = val
            else
                sing = val
            end
        end
        return false if quad == 0
        [quad, sing]
    end

    def full_house?
        return false if three_of_a_kind? == false
        trip_val = three_of_a_kind?[0]
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        values.reject! {|val| val == trip_val}
        return false if values[0] != values[1]
        [trip_val, values[0]] 
    end

    def flush?
        suit = @cards[0].suit
        return false if @cards.any? {|card| card.suit != suit}
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        values.sort!.reverse!
    end

    def straight?
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        values.sort!.reverse!
        (0...values.length-1).each do |i|
            return false if values[i] - values[i+1] != 1
        end
        [values[0]]
    end

    def three_of_a_kind?
        trip_val = 0
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        (0...values.length-1).each do |i1|
            val1 = values[i1]
            (i1+1..values.length-1).each do |i2|
                val2 = values[i2]
                if val1 == val2
                    (i2+1..values.length-1).each do |i3|
                        val3 = values[i3]
                        if val2 == val3
                            trip_val = val2
                        end
                    end
                end
            end
        end
        return false if trip_val == 0
        values.reject! {|val| val == trip_val}
        values.sort!.reverse!
        values.unshift(trip_val)
        values
    end

    def two_pair?
        pair_vals = []
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        (0...values.length-1).each do |i1|
            val1 = values[i1]
            (i1+1..values.length-1).each do |i2|
                val2 = values[i2]
                if val1 == val2
                    pair_vals << val1
                end
            end
        end
        return false if pair_vals.length < 2
        pair_vals.sort!.reverse!
        values.reject! {|val| pair_vals.include?(val)}
        values = pair_vals + values.sort.reverse
        values
    end

    def pair?
        pair_val = 0
        values = []
        @cards.each { |card| values << CARD_VALUES[card.val]}
        (0...values.length-1).each do |i1|
            val1 = values[i1]
            (i1+1..values.length-1).each do |i2|
                val2 = values[i2]
                if val1 == val2
                    pair_val = val1
                end
            end
        end
        return false if pair_val == 0
        values.reject! {|val| val == pair_val}
        values.unshift(pair_val)
        values
    end

    def high_card
        tie = []
        @cards.each do |card|
            card_val = CARD_VALUES[card.val]
            tie << card_val
        end
        tie.sort.reverse
    end
    
end