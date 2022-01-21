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

    def add(num)
        num.times do
            @cards << @deck.remove
        end
    end

    def hand_value?
        if royal_flush?
            val = royal_flush?
        elsif straight_flush?
            val = royal_flush?
        elsif four_of_a_kind?
            val = four_of_a_kind?
        elsif full_house?
            val = full_house?
        elsif flush?
            val = flush?
        elsif straight?
            val = straight?
        elsif three_of_a_kind?
            three_of_a_kind?
        elsif two_pair?
            val = two_pair?
        elsif pair?
            val = pair?
        else
            val = "high_card"
        end
        val_index = HAND_RANKS.index(val)
        return [high_card, val_index]
    end

    def high_card
        val = 0
        @cards.each do |card|
            card_val = CARD_VALUES[card.val]
            if card_val > val
                val = card_val
            end
        end
        val
    end

    def royal_flush?
        if straight_flush? && high_card == 14
            return "royal_flush"
        end
        false
    end

    def straight_flush?
        if straight? && flush?
            return "straight_flush"
        end
        false
    end

    def four_of_a_kind?

    end

    def full_house?

    end

    def flush?

    end

    def straight?

    end

    def three_of_a_kind?

    end

    def two_pair?

    end

    def pair?

    end
    
end