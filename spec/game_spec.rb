require 'rspec'
require 'game'

describe Game do

    subject(:game) { Game.new(100, ["Bert", "Rob", "Robert"]) }

    describe "#initialize" do

        it "sets @current_pot to 0" do
            expect(game.current_pot).to eq(0)
        end

        it "sets @players to Player classes" do
            expect(game.players[0].class).to eq(Player)
        end

        it "sets @deck to new deck classes" do
            expect(game.deck.class).to eq(Deck)
        end

        it "sets the given amount of players with their given names and pot" do
            expect(game.players.length).to eq(3)
            expect(game.players[0].name).to eq("Bert")
            expect(game.players[0].pot).to eq(100)
        end

    end

    describe "#game_over?" do

        it "makes @game_over false if more than one player have more than 0 pot" do
            expect(game.game_over).to eq(false)
        end

        it "makes @game_over true if more than one player have more than 0 pot" do
            game.players[0].pot = 0
            game.players[1].pot = 0
            expect(game.game_over).to eq(true)
        end

    end

    describe "#change_turn" do

        it "changes turn index" do
            game.change_turn
            expect(game.turn).to eq(1)
            game.change_turn
            game.change_turn
            expect(game.turn).to eq(0)
        end

        it "skips players with no pot" do
            game.players[1].pot = 0
            game.change_turn
            expect(game.turn).to eq(2)
        end

    end

    describe "#players_left_in_round" do

        it

    end

end