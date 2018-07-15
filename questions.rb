class Questions
  def initialize
    @question_number = 0
    @game_number = rand(0..4)
    file = File.read('questions.json')
    @questions = JSON.parse(file)["games"][@game_number]["questions"]
  end

  def get_question
    @current_question = @questions[@question_number]["question"]
    puts @current_question
    puts
  end

  def list_choices
    @choices = @questions[@question_number]["content"]
    x = 1
    @choices.each do |choice|
      puts "#{x}: " "#{choice}"
      x+=1
    end
    puts
  end

  def get_answer
    @answer = @questions[@question_number]["correct"]
    return @answer
  end

  def increment_question
    @question_number += 1
  end



end
