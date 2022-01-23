require_relative "hand"
require "byebug"

class Player

    attr_reader :hand, :name
    attr_accessor :pot, :in_round, :in_game, :current_bet

    def initialize(name, pot)
        @pot = pot
        @hand = []
        @name = name
        @in_round = true
        @in_game = true
        @current_bet = 0
    end

    def deal_hand(deck)
        @hand = Hand.new(deck)
    end

    def discard
        puts "Cards: #{@hand.inspect}"
        puts "#{@name}, enter indices of cards to discard with no spaces. blank to discard none"
        input = gets.chomp
        # debugger
        if input != "" && input != " "
            indices = input.split("")
            indices.map! do |index|
                index.to_i
            end
            hand.remove(indices)
        end
    end

    def bet(amount)
        puts "Cards: #{@hand.inspect}"
        puts "#{@name}, enter fold, call, or bet/raise"
        input = gets.chomp
        if input == "fold"
            return "fold"
        elsif input == "call"
            return amount
        else
            bet = raise_bet
            if bet <= amount
                puts "raise must be greater than previous bet"
                sleep(3)
                # bet(amount)
                raise "must be greater than previous bet"
            end
            bet
        end
    end

    def raise_bet
        puts "enter bet/raise amount"
        input = gets.chomp
        input.to_i
    end

end