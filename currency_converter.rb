require './currency.rb'

class CurrencyConverter
  def initialize(rates)
    @conversion = rates
  end

  def convert(convertee, currency_type)
    # number_of_euro = currency.amount * rates[:EUR] / rates[currency.code]
    amount = convertee.amount * @conversion[currency_type] / @conversion[convertee.currency_type]

    return Currency.new(amount, currency_type)
  end
# return a currency object

end
