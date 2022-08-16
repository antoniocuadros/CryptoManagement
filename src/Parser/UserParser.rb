# frozen_string_literal: true

require_relative '../../src/User'

class UserParser
  include BCrypt

  def user_to_json(user)
    return json_user = {
      'user_name' => user.user_name,
      'password' => user.password
    }
  end

  def json_to_user(json_user)
    user = User.new(json_user['user_name'], '')
    user.password = json_user['password']
    return user
  end
end
