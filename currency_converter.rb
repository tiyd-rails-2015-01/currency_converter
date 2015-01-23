require './currency'
require './unknown_currency_code_error'


class CurrencyConverter < Currency
  attr_reader :currency_codes
  def initialize(currency_codes)
    @currency_codes = currency_codes
  end

  def valid_currency_code?(code)
    currency_codes.keys.include?(code)
  end

  def convert(current_money, desired_type)
    if !valid_currency_code?(desired_type) || !valid_currency_code?(current_money.code)
      raise UnknownCurrencyCodeError, "Sorry, we do not have the rates for that currency type."
    elsif current_money.code == desired_type
      Currency.new(current_money.amount, desired_type)
    else
      my_cash = current_money.amount
      changed_cash =  my_cash * currency_codes[desired_type] / currency_codes[current_money.code]
      Currency.new(changed_cash, desired_type)
    end
  end

end
