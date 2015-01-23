require './currency'


class CurrencyConverter < Currency
  attr_reader :currency_rates
  def initialize(currency_rates)
    @currency_rates = currency_rates
    end

end
