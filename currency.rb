require './different_currency_code_error'


class Currency
  attr_reader :amount, :code
  def initialize(amount, code)
    @amount = amount
    @code = code
  end

  def == (other_money)
    self.amount == other_money.amount && self.code == other_money.code
  end

  def + (other_money)
    if self.code == other_money.code
      Currency.new(amount + other_money.amount, code)
    else
      raise DifferentCurrencyCodeError, "You cannot add two different kinds of currency"
    end
  end

  def - (other_money)
    if self.code == other_money.code
      Currency.new(amount - other_money.amount, code)
    else
      raise DifferentCurrencyCodeError, "You cannot subtract two different kinds of currency."
    end
  end

  def * (number)
    Currency.new(amount * number, code)
  end

end
