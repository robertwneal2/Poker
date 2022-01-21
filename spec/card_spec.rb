require 'rspec'
require 'card'

describe Card do

    subject(:card) { Card.new("j")}

    it "has a readable value" do
        expect(card.val).to eq("j")
    end

end