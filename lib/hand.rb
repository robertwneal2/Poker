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

    attr_reader :cards, :deck
    def initialize(deck)
        @deck = deck
        @cards = []
        5.times do
            @cards << @deck.remove
        end
    end

    def remove(indices)
        indices.each do |index|
            @cards.delete_at(index)
        end
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
            val = "two pair"
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
        if straight_flush? && high_card == 14
            return true
        end
        false
    end

    def straight_flush?
        if straight? && flush?
            return true
        end
        false
    end

    def four_of_a_kind?
        false
    end

    def full_house?
        false
    end

    def flush?
        false
    end

    def straight?
        false
    end

    def three_of_a_kind?
        false
    end

    def two_pair?
        false
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