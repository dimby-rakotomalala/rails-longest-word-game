require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = []
    counter = 0
    while counter < 8
      letter = [*('A'..'Z')].sample
      @grid << letter
      counter +=1
    end
    @grid
  end

  def score
    @grid = params['grid'].split(" ")
    @answer = params['answer'].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word = open(url).read
    word = JSON.parse(word)
    @found = word['found']
    if @found == false
      @result = "Sorry but #{@answer} does't seem to be a valid English word..."
      @score = 'Your score : 0. Try again!'
    elsif @answer.chars.all? { |letter| @answer.count(letter) <= @grid.count(letter) }
      @result = "Congratulations! #{@answer} is a valid English word!"
      @score = "Your score : #{@answer.length}/8"
    else
      @result = "Sorry but #{@answer} can't be built out of #{params['grid']}"
      @score = 'Your score : 0. Try again!'
    end
  end
end
