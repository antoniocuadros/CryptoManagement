# frozen_string_literal: true

require 'bcrypt'

class User
  include BCrypt
  attr_accessor :user_name, :password

  def initialize(user_name, password)
    @user_name = user_name
    @password = BCrypt::Password.create(password)
  end

  def password
    @password ||= Password.new(password_hash)
  end
end
