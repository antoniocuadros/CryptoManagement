# frozen_string_literal: true

require_relative '../../src/Portfolio'
require_relative '../../src/Coin'
require_relative '../../src/User'
require_relative '../Parser/CoinParser'
require_relative '../Parser/UserParser'

class PortfolioParser
  def initialize
    @coin_parser = CoinParser.new
    @user_parser = UserParser.new
  end

  def portfolio_to_json(portfolio)
    coins = []

    for i in 0..portfolio.num_coins-1
      coins.push(@coin_parser.coin_to_json(portfolio.coins[i]))
    end

    return json_portfolio = {
      'name' => portfolio.name,
      'coins' => coins,
      'user' => @user_parser.user_to_json(portfolio.user)
    }
  end

  def json_to_portfolio(json_portfolio)
    portfolio = Portfolio.new(json_portfolio['name'], @user_parser.json_to_user(json_portfolio['user']))

    for i in 0..json_portfolio['coins'].length()-1
      portfolio.add_coin(@coin_parser.json_to_coin(json_portfolio['coins'][i]))
    end

    return portfolio
  end
end
