require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    @letters
  end

  def english_word?()
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end

  def include?()
    @answer.upcase.chars.all? { |letter| @letters.include?(letter)}
  end

  def score
    @answer = params[:word]
    @letters = params[:letters].split(" ")
    if !include?()
      @score = "you didn't use the letters proposed!"
    elsif !english_word?()
      @score =  "This is not an English word!"
    else
      @score = "Congratulations!"
    end
  end
end
