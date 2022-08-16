# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../src/Parser/PortfolioParser'
require_relative '../../src/Parser/UserParser'
require_relative '../../src/Parser/CoinParser'
require_relative '../../src/User'
require_relative '../../src/Portfolio'
require 'json'

class PortfolioParserTest < Minitest::Test
  def setup
    @portfolio_parser = PortfolioParser.new
    @user_parser = UserParser.new
    @coin_parser = CoinParser.new
    @user = User.new('test_name', 'test_password')
    @portfolio = Portfolio.new('test_portfolio', @user)
    @coin1 = Coin.new('Btc_test', 'BTC')
    @coin2 = Coin.new('Eth_test', 'ETH')
    @portfolio.add_coin(@coin1)
    @portfolio.add_coin(@coin2)
  end

  def test_portfolio_to_json
    json = @portfolio_parser.portfolio_to_json(@portfolio)

    assert_equal @portfolio.name, json['name']
    assert_equal @portfolio.user.user_name, @user_parser.json_to_user(json['user']).user_name
    assert_same @portfolio.user.password, @user_parser.json_to_user(json['user']).password
    assert_equal @portfolio.coins[0].name, @coin_parser.json_to_coin(json['coins'][0]).name
    assert_equal @portfolio.coins[0].abbreviation, @coin_parser.json_to_coin(json['coins'][0]).abbreviation
  end

  def test_json_to_porftolio
    json = {
      'name' => 'test_name',
      'coins' => [@coin_parser.coin_to_json(@coin1), @coin_parser.coin_to_json(@coin2)],
      'user' => @user_parser.user_to_json(@user)
    }

    portfolio = @portfolio_parser.json_to_portfolio(json)

    assert_equal portfolio.name, json['name']
    assert_equal portfolio.coins[0].name, json['coins'][0]['name']
    assert_equal portfolio.coins[0].abbreviation, json['coins'][0]['abbreviation']
    assert_equal portfolio.coins[1].name, json['coins'][1]['name']
    assert_equal portfolio.coins[1].abbreviation, json['coins'][1]['abbreviation']
  end
end
