require 'rspec'
require 'hand'

describe Hand do

    let(:deck) {Deck.new}
    subject(:hand) {Hand.new(deck)}

    describe "#initialize" do

        it "dealt 5 cards from deck" do
            expect(hand.cards.length).to eq(5)
            expect(hand.cards[0].class).to eq(Card)
        end

    end

    describe "#remove(indices)" do

        it "removes cards from hand at each index in indices array" do
            first_card = hand.cards[0]
            second_card = hand.cards[1]
            hand.remove([0])
            expect(hand.cards[0]).to_not eq(first_card)
            expect(hand.cards[0]).to eq(second_card)
        end

        it "calls #add(num)" do
            indices = [0]
            indices_length = indices.length
            expect(hand).to receive(:add)
            hand.remove(indices)
        end

    end

    describe "#add(num)" do

        it "calls deck.remove" do
            expect(hand.deck).to receive(:remove)
            hand.add(1)
        end

        it "increases hand's card count by given number" do
            card_count = hand.cards.count
            hand.add(1)
            expect(hand.cards.count).to eq(card_count + 1)
        end

    end

    describe "#high_card" do
        
        it "returns value of highest card" do
            hand.cards[0] = Card.new("2", "H")
            hand.cards[1] = Card.new("3", "H")
            hand.cards[2] = Card.new("4", "H")
            hand.cards[3] = Card.new("5", "H")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.high_card).to eq(9)
        end

    end

    describe "#hand_value?" do

        it "returns hand value in form of [high_card value, index of hand value]" do
            hand.cards[0] = Card.new("2", "H")
            hand.cards[1] = Card.new("3", "H")
            hand.cards[2] = Card.new("4", "H")
            hand.cards[3] = Card.new("5", "H")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.hand_value?).to eq([9,0])
        end

    end

    describe "#royal_flush?" do

        it "returns 'royal_flush' if true" do

        end

        it "returns false if false" do
            hand.cards[0] = Card.new("2", "H")
            hand.cards[1] = Card.new("3", "H")
            hand.cards[2] = Card.new("4", "H")
            hand.cards[3] = Card.new("5", "H")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.royal_flush?).to eq(false)
        end

    end

end