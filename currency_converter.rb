require './currency'


class CurrencyConverter < Currency
  attr_reader :currency_rates
  def initialize(currency_rates)
    @currency_rates = currency_rates
    end

  def convert(current_money, desired_type)
    # if !(currency_rates.keys.include?(desired_type))
    #   raise UnknownCurrencyCodeError, "Sorry, we do not have the rates for that currency type."
    if current_money.code == desired_type
      Currency.new(current_money.amount, desired_type)
    # elsif
    #   my_money = current_money.amount
    #   total = my_money * currency_rates[desired_type] / currency_rates[current_money.currency_code]
    #   Currency.new(total, desired_type)
    end
  end

end
