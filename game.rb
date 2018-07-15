require 'json'
require_relative 'questions.rb'
require_relative 'money.rb'
require_relative 'player.rb'

class Game

def initialize
  @questions = Questions.new
  @money = Money.new
  @player = Player.new
  @round = 0
  @guess = nil
  @walk_away_decision = nil
  @winnings = nil
  @guaranteed = []
  system "clear"
  puts "Let's Play Who Wants to Be a Millionaire!"
  puts
end

def start
  until game_over?
    play
  end
end

def play
  display_question
  display_choices
  walk_away?
  get_decision
  get_guess
  check_answer
  increment_round
  next_question
end


def display_choices
  @questions.list_choices
end

def display_purse
  @money.purse_value
end

def display_question
  puts "Question #{@round +1} is for #{display_purse}."
  @questions.get_question
end


def walk_away?
  if @round >= 1
    puts "Which would you like to do?"
    puts
    puts "1. Keep Playing"
    puts "2. Walk Away with #{@winnings}."
    puts
    puts "Type 1 or 2."
    @walk_away_decision = gets.chomp.to_i
  end
end

def get_decision
  while @round >= 1
    if @walk_away_decision == 1
      puts "Great, let's play on. Good luck!"
      display_question
      display_choices
      return
    else
      puts "Wise decision with the guaranteed money. You're going home with #{@winnings}!"
      puts "Thanks for playing Who Wants to Be a Millionaire. Good night."
      exit
    end
  end
end

def get_guess
  puts "Pick an answer between 1 and 4."
  puts
  @guess = gets.chomp.to_i
  puts
end

def the_answer
  @questions.get_answer
end

def check_guaranteed
  if @winnings == "$1,000" || @winnings == "$32,000"
    @guaranteed << @winnings
  end
end

def award_guaranteed
  if @guaranteed.count > 0
    puts "The good news is you're still going home with #{@guaranteed.last}."
  end
end

def notify_guaranteed
  if @guaranteed.count == 1 && @round == 4
    puts "You've secured guaranteed money. From here out you'll leave with a guaranteed #{@guaranteed.last}."
  elsif @guaranteed.count == 2 && @round == 9
    puts "You've secured more guaranteed money. From here out you'll leave with a guaranteed #{@guaranteed.last}."
  else
    return
  end
end

def check_answer
  if @guess - 1 == the_answer
    @winnings = display_purse
    puts "Correct!"
    check_guaranteed
    notify_guaranteed
    puts
    increment_prize
    is_millionaire?
  else
    puts "I'm sorry, that is not correct."
    award_guaranteed
    @round = 100 #game over
  end
end


def award_prize
  @money.get_money
  puts
end

def increment_prize
  @money.increment_value
end

def increment_round
  @round += 1
end

def next_question
  @questions.increment_question
end

def is_millionaire?
  if @round == 14
    puts "Congratulations, you are a millionaire!"
  end
end


def game_over?
  if @round > 14
    puts "Game Over"
    exit
  else
    false
  end
end




end

@game = Game.new
@game.start
