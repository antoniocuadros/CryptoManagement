# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../src/Parser/UserParser'
require_relative '../../src/User'
require 'bcrypt'
require 'json'

class UserParserTest < Minitest::Test
  def setup
    @user_parser = UserParser.new
    @user = User.new('test_name', 'test_password')
  end

  def test_user_to_json
    json = @user_parser.user_to_json(@user)

    assert_equal @user.user_name, json['user_name']
    assert_same @user.password, json['password']
  end

  def test_json_to_user
    json = {
      'user_name' => 'test_name',
      'password' => 'TA'
    }

    user2 = @user_parser.json_to_user(json)

    assert_equal user2.user_name, json['user_name']
    assert_same user2.password, json['password']
  end
end
