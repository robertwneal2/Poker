require 'rspec'
require 'card'

describe Card do

    subject(:card) { Card.new("J", "C")}

    it "has a readable value and suit" do
        expect(card.val).to eq("J")
        expect(card.suit).to eq("C")
    end

end