# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../src/Parser/CoinParser'
require_relative '../../src/Coin'
require_relative '../../src/Operation'
require_relative '../../src/OperationType'
require 'json'

class CoinParserTest < Minitest::Test
  def setup
    @coin_parser = CoinParser.new
    @operation_parser = OperationParser.new
    @buy_operation = Operation.new(3, 2, 1, OperationType::BUY, 1, 'BUY AntonioCoin', '321')
    @sell_operation = Operation.new(1, 2, 3, OperationType::SELL, 1, 'SELL AntonioCoin', '123')
    @coin = Coin.new('test_name', 'test_abbr')
    @coin.add_operation(@buy_operation)
    @coin.add_operation(@sell_operation)
  end

  def test_coin_to_json
    json = @coin_parser.coin_to_json(@coin)

    assert_equal 'test_name', json['name']
    assert_equal 'test_abbr'.upcase, json['abbreviation']

    assert_equal 2, json['operations'].length
    assert_equal 3, json['operations'][0]['coin_price']
    assert_equal OperationType::BUY, json['operations'][0]['type']
    assert_equal '321', json['operations'][0]['date']

    assert_equal 1, json['operations'][1]['coin_price']
    assert_equal OperationType::SELL, json['operations'][1]['type']
    assert_equal '123', json['operations'][1]['date']
  end

  def test_json_to_coin
    json = {
      'name' => 'test_name',
      'abbreviation' => 'TA',
      'operations' => [
        {
          'coin_price' => 3,
          'coin_units' => 2,
          'usd_amount' => 1,
          'type' => OperationType::BUY,
          'fee' => 1,
          'note' => 'BUY AntonioCoin',
          'date' => '321'
        },
        {
          'coin_price' => 1,
          'coin_units' => 2,
          'usd_amount' => 3,
          'type' => OperationType::SELL,
          'fee' => 1,
          'note' => 'SELL AntonioCoin',
          'date' => '123'
        }
      ]
    }

    coin = @coin_parser.json_to_coin(json)

    assert_equal 'test_name', coin.name
    assert_equal 'TA', coin.abbreviation

    assert_equal @buy_operation, coin.operation(@buy_operation)
    assert_equal @sell_operation, coin.operation(@sell_operation)
  end
end
