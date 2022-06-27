require "minitest/autorun"
require "minitest/mock"
require_relative "../src/PortfolioManager.rb"
require_relative "../src/Portfolio.rb"

class PortfolioManagerTest < Minitest::Test

    def setup
        @portfolioManager = PortfolioManager.new()
        @portfolio = Portfolio.new("onePortfolio")
        @portfolio2 = Portfolio.new("anotherPortfolio")
    end

    def test_AddPortfolio
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_equal "onePortfolio", @portfolioManager.GetPortfolio(@portfolio).name
    end

    def test_GetPortfolio_PortfolioExists_PortfolioReturned
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_equal "onePortfolio", @portfolioManager.GetPortfolio(@portfolio).name
    end

    def test_GetPortfolio_PortfolioDoesNotExist_NilReturned
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_nil @portfolioManager.GetPortfolio(@portfolio2)
    end

    
end