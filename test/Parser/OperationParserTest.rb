# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../src/Parser/OperationParser'
require_relative '../../src/Operation'
require_relative '../../src/OperationType'
require 'json'

class OperationParserTest < Minitest::Test
  def setup
    @operation_parser = OperationParser.new
    @buy_operation = Operation.new(20, 10, 200, OperationType::BUY, 1, 'BUY AntonioCoin', '123')
  end

  def test_operation_to_json
    json = @operation_parser.operation_to_json(@buy_operation)

    assert_equal 20, json['coin_price']
    assert_equal 10, json['coin_units']
    assert_equal 200, json['usd_amount']
    assert_equal OperationType::BUY, json['type']
    assert_equal 1, json['fee']
    assert_equal 'BUY AntonioCoin', json['note']
    assert_equal '123', json['date']
  end

  def test_json_to_operation
    json = {
      'coin_price' => 20,
      'coin_units' => 10,
      'usd_amount' => 200,
      'type' => OperationType::BUY,
      'fee' => 1,
      'note' => 'BUY AntonioCoin',
      'date' => '123'
    }

    operation = @operation_parser.json_to_operation(json)

    assert_equal 20, operation.coinPrice
    assert_equal 10, operation.coinUnits
    assert_equal 200, operation.usdAmount
    assert_equal OperationType::BUY, operation.type
    assert_equal 1, operation.fee
    assert_equal 'BUY AntonioCoin', operation.note
    assert_equal '123', operation.date
  end
end
