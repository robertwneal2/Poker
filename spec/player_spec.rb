require 'rspec'
require 'player'

describe Player do

    subject(:player) { Player.new("Bert", 100) }
    let(:deck) { Deck.new }

    describe "#initialize" do

        it "initializes the pot with given value" do
            expect(player.pot).to eq(100)
        end

        it "initializes the hand with empty array" do
            expect(player.hand).to eq([])
        end

    end

    describe "#deal_hand" do

        it "gives player 5 cards" do
            player.deal_hand(deck)
            expect(player.hand.cards.length).to eq(5)
            expect(player.hand.cards[0].class).to eq(Card)
        end

    end

end