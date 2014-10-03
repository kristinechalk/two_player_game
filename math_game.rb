require 'colorize'

class Game

  def player_name(num)
    puts "Please enter your player name: #{num}"
    player_name = gets.chomp.capitalize
  end

  def generate_question
    random1 = rand(1-20)
    random2 = rand(1-20)
    
    questions = [
      ["#{@current_user.name}: What does #{random1} plus #{random2} equal?", random1 + random2],
      ["#{@current_user.name}: What does #{random1} minus #{random2} equal?", random1 - random2],
      ["#{@current_user.name}: What does #{random1} multiplied by #{random2} equal?", random1 * random2],
      ["#{@current_user.name}: What does #{random1} divied by #{random2} equal?", random1 / random2]
    ]

    random_question = questions[rand(0-4)]
    puts "\n" << random_question[0]
    @question_result = random_question[1]
  end

  def get_answer
      @player_answer = gets.chomp.to_i
  end

  def verify_answer
    if @question_result == @player_answer 
      puts "You are correct!".green
    else
      @current_user.lives -= 1
      puts "You are incorrect!".red
      puts "#{@player1.name} you have #{@player1.lives} lives left."
      puts "#{@player2.name} you have #{@player2.lives} lives left."
    end
  end

  def switch_user
    if @player1 == @current_user
      @current_user = @player2
    else 
      @current_user = @player1
    end
  end

  def play_again?
    puts "\nWould you guys like to play again?"
    response = gets.chomp.downcase
      if response == "yes"
        run
      else 
        exit
      end
  end

  def run
    player1_name = player_name(1)
    @player1 = Player.new(player1_name)

    player2_name = player_name(2)
    @player2 = Player.new(player2_name)

    @current_user = @player1

    puts "\n#{@player1.name} you have #{@player1.lives} lives."
    puts "#{@player2.name} you have #{@player2.lives} lives."
    
    while @current_user.lives > 0
      generate_question
      get_answer
      verify_answer

      if @current_user.lives == 0
        puts "\nUh oh! #{@current_user.name}, you lose."
        
        switch_user
        
        puts "\n#{@current_user.name} you have won! Congratulations! You have #{@current_user.lives} lives left."
        
        play_again?
      end

      switch_user
    end
  end

end


 
class Player

  attr_accessor :name, :lives

  def initialize(name)
    @name = name
    @lives = 3
  end

end


trial = Game.new
trial.run



