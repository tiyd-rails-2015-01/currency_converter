class Currency
  attr_reader :amount, :currency_code

  def initialize(amount, currency_code)
    @amount = amount
    @currency_code = currency_code
  end

  def ==(other)
    amount == other.amount &&
      currency_code == other.currency_code
  end

  def +(other)
    if currency_code == other.currency_code
      Currency.new(amount + other.amount, currency_code)
    else
      raise DifferentCurrencyCodeError.new("different currencies cannot be added")
    end
  end

  def -(other)
    if currency_code == other.currency_code
      Currency.new(amount - other.amount, currency_code)
    else
      raise DifferentCurrencyCodeError.new("different currencies cannot be subtracted")
    end
  end
end
