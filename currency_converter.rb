require './currency'
require './currency_test'
require 'pry'


class CurrencyConverter < Currency
  attr_reader :currency_codes
  def initialize(currency_codes)
    @currency_codes = currency_codes
    end

  def convert(current_money, desired_type)
    # if !(currency_rates.keys.include?(desired_type))
    #   raise UnknownCurrencyCodeError, "Sorry, we do not have the rates for that currency type."
    if current_money.code == desired_type
      Currency.new(current_money.amount, desired_type)
    else
      my_cash = current_money.amount
      changed_cash =  my_cash * currency_codes[desired_type] / currency_codes[current_money.code]
      Currency.new(changed_cash, desired_type)
      # binding.pry
    end
  end

end




# money_machine = CurrencyConverter.new({USD: 1.00000,
#   EUR: 0.86384,
#   GBP: 0.66054,
#   AUD: 1.23455,
#   CAD: 1.23290,
#   JPY: 117.874})
#
#   my_money = Currency.new(5, :USD)
#   changed_money = money_machine.convert(my_money, :EUR)
#   puts changed_money
