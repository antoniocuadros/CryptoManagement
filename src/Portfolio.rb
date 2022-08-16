# frozen_string_literal: true

require_relative 'Coin'
require_relative 'User'

class Portfolio
  attr_accessor :name, :user, :coins

  def initialize(name, user)
    @name = name
    @coins = []
    @user = user
  end

  def add_coin(coin)
    @coins.push(coin)
  end

  def coin(coin)
    @coins.include?(coin) ? @coins.at(@coins.find_index(coin)) : nil
  end

  def delete_coin(coin)
    @coins.delete(coin)
  end

  def coin_by_name(name)
    found = false
    coin = nil
    i = 0

    while i < @coins.length() and !found
      if(@coins[i].name == name)
        found = true
        coin = @coins[i]
      end
      i += 1
    end

    coin
  end

  def num_coins
    @coins.length
  end
end
