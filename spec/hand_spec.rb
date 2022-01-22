require 'rspec'
require 'byebug'
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

    # describe "#add(num)" do

    #     it "calls deck.remove" do
    #         expect(hand.deck).to receive(:remove)
    #         hand.add(1)
    #     end

    #     it "increases hand's card count by given number" do
    #         card_count = hand.cards.count
    #         hand.add(1)
    #         expect(hand.cards.count).to eq(card_count + 1)
    #     end

    # end

    describe "#hand_value?" do

        it "returns royal flush rank and highest card value" do
            hand.cards[0] = Card.new("10", "H")
            hand.cards[1] = Card.new("J", "H")
            hand.cards[2] = Card.new("Q", "H")
            hand.cards[3] = Card.new("K", "H")
            hand.cards[4] = Card.new("A", "H")
            expect(hand.hand_value?).to eq([9,[14]])
        end

        it "returns straight flush rank and highest card value" do
            hand.cards[0] = Card.new("10", "H")
            hand.cards[1] = Card.new("J", "H")
            hand.cards[2] = Card.new("Q", "H")
            hand.cards[3] = Card.new("K", "H")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.hand_value?).to eq([8,[13]])
        end

        it "returns four of a kind rank, value, and kicker" do
            hand.cards[0] = Card.new("10", "H")
            hand.cards[1] = Card.new("10", "S")
            hand.cards[2] = Card.new("10", "C")
            hand.cards[3] = Card.new("10", "D")
            hand.cards[4] = Card.new("A", "H")
            expect(hand.hand_value?).to eq([7,[10,14]])
        end

        it "returns full house rank, triple value, and double value" do
            hand.cards[0] = Card.new("10", "H")
            hand.cards[1] = Card.new("10", "S")
            hand.cards[2] = Card.new("10", "C")
            hand.cards[3] = Card.new("J", "D")
            hand.cards[4] = Card.new("J", "H")
            # debugger
            expect(hand.hand_value?).to eq([6,[10,11]])
        end

        it "returns flush rank and high cards in order" do
            hand.cards[0] = Card.new("2", "H")
            hand.cards[1] = Card.new("J", "H")
            hand.cards[2] = Card.new("5", "H")
            hand.cards[3] = Card.new("A", "H")
            hand.cards[4] = Card.new("8", "H")
            expect(hand.hand_value?).to eq([5,[14,11,8,5,2]])
        end

        it "returns straight rank high card" do
            hand.cards[0] = Card.new("5", "H")
            hand.cards[1] = Card.new("7", "S")
            hand.cards[2] = Card.new("8", "H")
            hand.cards[3] = Card.new("6", "C")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.hand_value?).to eq([4,[9]])
        end

        it "returns three of a kind rank, trip card value, and remaining, card values in decending order" do
            hand.cards[0] = Card.new("5", "H")
            hand.cards[1] = Card.new("5", "S")
            hand.cards[2] = Card.new("5", "C")
            hand.cards[3] = Card.new("6", "C")
            hand.cards[4] = Card.new("9", "H")
            expect(hand.hand_value?).to eq([3,[5,9,6]])
        end

        it "returns two pair rank, high pair value, low pair value, then last card" do
            hand.cards[0] = Card.new("8", "H")
            hand.cards[1] = Card.new("5", "S")
            hand.cards[2] = Card.new("8", "C")
            hand.cards[3] = Card.new("Q", "C")
            hand.cards[4] = Card.new("Q", "H")
            expect(hand.hand_value?).to eq([2,[12,8,5]])
        end
        it "returns pair rank, pair value, and remaining card's values in decending order" do
            hand.cards[0] = Card.new("7", "H")
            hand.cards[1] = Card.new("K", "S")
            hand.cards[2] = Card.new("7", "H")
            hand.cards[3] = Card.new("10", "C")
            hand.cards[4] = Card.new("2", "H")
            expect(hand.hand_value?).to eq([1,[7,13,10,2]])
        end

        it "returns high card value and card's values in decending order" do
            hand.cards[0] = Card.new("2", "H")
            hand.cards[1] = Card.new("3", "C")
            hand.cards[2] = Card.new("4", "C")
            hand.cards[3] = Card.new("5", "H")
            hand.cards[4] = Card.new("9", "S")
            expect(hand.hand_value?).to eq([0,[9,5,4,3,2]])
        end

    end

    # describe "#royal_flush?" do

    #     it "returns 'royal_flush' if true" do

    #     end

    #     it "returns false if false" do
    #         hand.cards[0] = Card.new("2", "H")
    #         hand.cards[1] = Card.new("3", "H")
    #         hand.cards[2] = Card.new("4", "H")
    #         hand.cards[3] = Card.new("5", "H")
    #         hand.cards[4] = Card.new("9", "H")
    #         expect(hand.royal_flush?).to eq(false)
    #     end

    # end

end