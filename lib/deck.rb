require 'byebug'
require_relative 'card'

class Deck

    CARD_VALUES = ["2", "3", "4", "5", "6", "7", "8",
                   "9", "10", "J", "Q", "K", "A"]

    CARD_SUITS = ["H", "D", "S", "C"]

    attr_reader :cards
    def initialize
        @cards = []
        CARD_VALUES.each do |val|
            CARD_SUITS.each do |suit|
                @cards << Card.new(val, suit)
            end
        end
        shuffle
    end

    def shuffle
        @cards = @cards.shuffle
    end

end