class CurrencyTrader
  def initialize( exchangeRatesOverTime, startingCurrency )
    @exchangeRatesOverTime = exchangeRatesOverTime
    @currentCurrency = startingCurrency
  end

  #snapshot1 and snapshot2 = CurrencyConverter objects
  def findBestTrade(snapshot1,snapshot2)
  end
end
