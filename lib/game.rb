require_relative "deck"
require_relative "player"
require "byebug"

class Game

    attr_reader :current_pot, :players, :deck, :turn

    def initialize(pot, player_names)
        @deck = Deck.new
        @players = []
        player_names.each do |player_name|
            @players << Player.new(player_name, pot)
        end
        @current_pot = 0
        @current_high_bet = 0
        @starter = 0
    end

    def play
        while game_over? == false
            deal
            bet_round
            if remaining_players.length > 1
                discard_round
                bet_round
            end
            end_of_round
        end
        winner
    end

    def bet_round
        @current_high_bet = 0
        @players.each do |player|
            if player.in_round == true
                begin
                    system("clear")
                    puts "Pot: #{@current_pot}, High Bet: #{@current_high_bet}, Player Pot: #{player.pot}"
                    player_move = player.bet(@current_high_bet)
                    if player_move == "fold"
                        player.in_round = false
                    else
                        if player_move > player.pot
                            @current_pot += player.pot
                            player.current_bet += player.pot
                            if player.pot > @current_high_bet
                                @current_high_bet = player.pot
                            end
                            player.pot = 0
                        else
                            @current_high_bet = player_move
                            player.pot -= player_move
                            @current_pot += player_move
                            player.current_bet += player_move
                        end
                    end
                rescue
                    retry
                end
            end
        end
        call_round
    end

    def call_round
        @players.each do |player|
            system("clear")
            puts "Pot: #{@current_pot}, High Bet: #{@current_high_bet}, Player Pot: #{player.pot}, Player Bet: #{player.current_bet}"
            if player.in_round == true
                if player.current_bet < @current_high_bet
                    puts "Cards: #{player.hand.inspect}"
                    puts "#{player.name}, call bet of #{@current_high_bet}? Enter 'y' or 'n'"
                    player_move = gets.chomp
                    if player_move == 'y'
                        call_diff = @current_high_bet - player.current_bet
                        if call_diff > player.pot
                            @current_pot += player.pot
                            player.current_bet += player.pot
                            player.pot = 0
                        else
                            player.pot -= call_diff
                            @current_pot += call_diff
                            player.current_bet += call_diff
                        end
                    else
                        player.in_round = false
                    end
                end
            end
        end
    end

    def discard_round
        @players.each do |player|
            system("clear")
            puts "Pot: #{@current_pot}, High Bet: #{@current_high_bet}, Player Pot: #{player.pot}"
            if player.in_round == true
                player.discard
            end
        end
    end

    def end_of_round
        round_winner
        @current_pot = 0
        eliminate_players
        sleep(3)
        next_starter
        @deck = Deck.new
    end

    def eliminate_players 
        @players.each do |player|
            if player.pot == 0
                puts "#{player.name} sucks at poker!"
                player.in_game = false
                player.in_round = false
            else
                player.in_round = true
                player.current_bet = 0
            end
        end
    end

    def round_winner
        remaining_hands = []
        remaining_players.each do |player|
            remaining_hands << player.hand
        end
        winning_hands = Hand.compare_hands(remaining_hands)
        num_winners = winning_hands.length
        remaining_players.each do |player|
            hand = player.hand
            if winning_hands.include?(hand)
                player.pot += @current_pot/num_winners
                puts "#{player.name} wins #{@current_pot/num_winners}"
                sleep(3)
            end
        end
    end

    def next_starter
        @starter = (@starter + 1) % @players.length
        next_starter if @players[@starter].in_game == false
    end

    def remaining_players
        remaining = []
        @players.each do |player|
            if player.in_round == true
                remaining << player
            end
        end
        remaining
    end

    def game_over?
        player_count = 0
        @players.each do |player|
            player_pot = player.pot
            if player_pot > 0
                player_count += 1
            end
        end
        return true if player_count == 1
        false
    end

    def winner
        @players.each do |player|
            puts "#{player.name} wins!" if player.in_game == true
        end
    end

    def deal
        @players.each do |player|
            if player.in_game == true
                player.deal_hand(@deck)
            end
        end
    end

end

if __FILE__ == $0
    players = ["Bert", "Rob", "Robert"]
    pot = 100
    Game.new(pot, players).play
end