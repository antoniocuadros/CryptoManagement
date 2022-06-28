require_relative "test_helper"
require_relative "../src/Portfolio.rb"

class PortfolioTest < Minitest::Test

    def setup

        @portfolio = Portfolio.new("NameTest", User.new("username", "password"))
        @antonioCoin = Coin.new("AntonioCoin", "ANC")
        @memeCoin = Coin.new("memeCoin", "MMC")
    end

    def test_GetNumCoins
        assert_equal 0, @portfolio.GetNumCoins
    end

    def test_AddCoin
        @portfolio.AddCoin(@antonioCoin)
        
        assert_equal 1, @portfolio.GetNumCoins
    end

    def test_GetCoinByName_TwoCoinsInPortfolio_ReturnsRequestedCoin
        @portfolio.AddCoin(@memeCoin)

        requestedCoin = @portfolio.GetCoinByName(@memeCoin.name)

        assert_equal 1, @portfolio.GetNumCoins
        assert_equal "memecoin", requestedCoin.name
        assert_equal "MMC", requestedCoin.abbreviation
    end

    def test_GetCoinByName_TwoCoinsInPortfolio_RequestedCoinNotExists
        requestedCoin = @portfolio.GetCoinByName("TEST")

        assert_nil requestedCoin
    end

    def test_GetCoin_TwoCoinsInPortfolio_RequestedCoinExists
        @portfolio.AddCoin(@memeCoin)
        @portfolio.AddCoin(@antonioCoin)

        requestedCoin = @portfolio.GetCoin(@memeCoin)
        
        refute_nil requestedCoin
        assert_equal "memecoin", requestedCoin.name
        assert_equal "MMC", requestedCoin.abbreviation
    end

    def test_GetCoin_OneCoinInPortfolio_RequestedCoinNotExists
        @portfolio.AddCoin(@memeCoin)

        requestedCoin = @portfolio.GetCoin(@antonioCoin)
        
        assert_nil requestedCoin
    end

    def test_DeleteCoin_TwoCoinsInPortfolio_DeletedOneCoin
        @portfolio.AddCoin(@memeCoin)
        @portfolio.AddCoin(@antonioCoin)

        deletedCoin = @portfolio.DeleteCoin(@memeCoin)
        
        assert_equal 1, @portfolio.GetNumCoins
        assert_equal "memecoin", deletedCoin.name
        assert_equal "MMC", deletedCoin.abbreviation
    end

    def test_DeleteCoin_OneCoinInPortfolio_NoDeletedCoin
        @portfolio.AddCoin(@antonioCoin)

        deletedCoin = @portfolio.DeleteCoin(@memeCoin)
        
        assert_nil deletedCoin
    end

    def test_SetName_OneCoinInPortfolio_NameChanged
        @portfolio.AddCoin(@memeCoin)

        @portfolio.name = "PortFolioTest"
        
        assert_equal "PortFolioTest", @portfolio.name
    end

end