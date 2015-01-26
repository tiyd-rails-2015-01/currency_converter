class CurrencyConverter <Currency
  attr_reader :conversion_rates

  def initialize(conversion_rates)
    @conversion_rates = conversion_rates
  end

  def convert(currency_object, code)
    new_amount = (currency_object.amount /
    conversion_rates[currency_object.currency_code]) *
    conversion_rates[code]
    Currency.new(new_amount, code)
  end
end
