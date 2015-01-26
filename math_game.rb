require 'colorize'
require_relative 'player'

require_relative 'custom_exception'

class Game

  def create_player
    player1_name = player_name(1)
    @player1 = Player.new(player1_name)

    player2_name = player_name(2)
    @player2 = Player.new(player2_name)

    @current_user = @player1

    puts "\n#{@player1.name} you have #{@player1.lives} lives."
    puts "#{@player2.name} you have #{@player2.lives} lives."
  end

  def player_name(num)
    puts "Please enter your player name: #{num}"
    player_name = gets.chomp.capitalize

    if player_name.empty?
      raise "Name cannot be empty."
    end
  end

  def generate_question
    random1 = Random.new
    random2 = Random.new

    random1 = rand(1..20)
    random2 = rand(1..20)
    
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

    unless @player_answer.is_a? Numeric
      raise InvalidGuessError 'Answer must be a number'
    end
  end

  def verify_answer
    if @question_result == @player_answer 
      puts "You are correct!".green
      gain_a_point
    else
      @current_user.lives -= 1
      puts "You are incorrect!".red
      puts "#{@player1.name} you have #{@player1.lives} lives left."
      puts "#{@player2.name} you have #{@player2.lives} lives left."
    end
  end

  def gain_a_point
    @current_user.points += 1

    if @current_user.points == 1
      puts "#{@current_user.name} you now have #{@current_user.points} point."
    else
    puts "#{@current_user.name} you now have #{@current_user.points} points."
    end
  end

  def switch_user
    if @player1 == @current_user
      @current_user = @player2
    else 
      @current_user = @player1
    end
  end

  def determine_winner
    if @player1.points > @player2.points 
      puts "\n#{@player1.name} you have won! Congratulations! You have #{@player1.points} points and #{@player1.lives} lives left."
      puts "\nUh oh! #{@player2.name}, you lose."
    elsif @player1.points == @player2.points
      puts "\n#{@player1.name} and #{@player2.name} you have tied with #{@player1.points} points."    
    else 
      puts "\n#{@player2.name} you have won! Congratulations! You have #{@player2.points} points and #{@player2.lives} lives left."
      puts "\nUh oh! #{@player1.name}, you lose."
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
    create_player

    while @current_user.lives > 0
      generate_question
      get_answer
      verify_answer

      if @current_user.lives == 0
        determine_winner

        play_again?
      end
      switch_user
    end
  end

end


trial = Game.new
trial.run



