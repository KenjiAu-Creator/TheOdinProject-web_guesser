require 'sinatra'
require 'sinatra/reloader'

class RandNum
  def initialize
    @secret = rand(100)
  end

  def number?
    return @secret
  end

  def reset
    @secret = rand(100)
  end
end

numberClass = RandNum.new

class GuessCount
  @@count = 6

  def initialize
    @@count -= 1
  end

  def getCount()
    return @@count
  end

  def resetCount()
    @@count = 6
  end
end

get '/' do
  playerGuess = params["guess"]
  cheat = params["cheat"]
  message = check_guess(playerGuess, number)
  color = backgroundColor(message, number)
  erb :index, :locals => {:number => number.secret, :guess => playerGuess, :message => message, :color => color, :cheat => cheat}
end

get '/test' do
  guessClass =  GuessCount.new
  playerGuess = params["guess"]
  cheat = params["cheat"]
  message = check_guess(playerGuess, numberClass.number?)
  color = backgroundColor(message, numberClass.number?)
  erb :test, :locals => {:numberClass => numberClass, :guess => playerGuess, :message => message, :color => color, :cheat => cheat, :count => guessClass.getCount, :guessClass => guessClass}
end

def check_guess(guess, number)
  numGuess = guess.to_i
  if numGuess > (number + 5)
    return 'Way too high!'
  elsif numGuess > number
    return "Too high!"
  elsif numGuess < (number-5)
    return 'Way too low!'
  elsif numGuess < number
    return "Too low!"
  elsif numGuess == number
    return "You got it right! \n The SECRET NUMBER is #{number}"
  end
end

def backgroundColor(message, number)
  case message
  when ('Way too high!')
    return 'red'
  when 'Way too low!'
    return 'red'
  when 'Too low!'
    return 'blue'
  when 'Too high!'
    return 'blue'
  when "You got it right! \n The SECRET NUMBER is #{number}"
    return 'green'
  end
end
