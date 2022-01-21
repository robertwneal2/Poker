require_relative "deck"

class Hand

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

end