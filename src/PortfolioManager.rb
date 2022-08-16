# frozen_string_literal: true

require_relative 'Portfolio'

class PortfolioManager
  def initialize
    @portfolios = []
  end

  def add_portfolio(portfolio)
    @portfolios.push(portfolio)
  end

  def portfolio(portfolio, user)
    portfolio = @portfolios.include?(portfolio) ? @portfolios.at(@portfolios.find_index(portfolio)) : nil

    if(!portfolio.nil? && portfolio.user.user_name != user.user_name)
      portfolio = nil
    end

    portfolio
  end

  def num_portfolios
    @portfolios.length
  end

  def delete_portfolio(portfolio)
    @portfolios.delete(portfolio)
  end
end
