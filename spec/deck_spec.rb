require 'rspec'
require 'deck'

describe Deck do

    subject(:deck) { Deck.new }

    it "deck initializes with a 'cards' variable of length 52" do
        expect(deck.cards.length).to eq(52)
    end

    it "deck contains Card instances" do
        expect(deck.cards[0].class).to eq(Card)
    end

    it "contains 13 different card values, 4 suits each" do
        expect(deck.cards.count { |card| card.val == "J"}).to eq(4)
        expect(deck.cards.uniq{ |card| card.val}.count).to eq(13)
        expect(deck.cards.uniq{ |card| card.suit}.count).to eq(4)
    end

    it "shuffles the deck on creation" do
        values = ["2", "3", "4", "5", "6", "7", "8",
                  "9", "10", "J", "Q", "K", "A"]
        suits = ["H", "D", "S", "C"]
        unshuffled_cards = []
        values.each do |val|
            suits.each do |suit|
                unshuffled_cards << [val, suit]
            end
        end
        shuffled_cards = []
        deck.cards.each do |card|
            val = card.val
            suit = card.suit
            shuffled_cards << [val, suit]
        end
        expect(shuffled_cards).to_not eq(unshuffled_cards)
    end

    it "removing card removes a card from deck" do
        deck.remove
        expect(deck.cards.length).to eq(51)
    end

    it "removing card returns that card" do
        card = deck.remove
        expect(deck.cards.include?(card)).to eq(false)
        expect(card.class).to eq(Card)
    end

end