class Currency
  def initialize(amount, currency_type = nil)
    if amount.class == Float || amount.class == Fixnum
      @amount = amount
      @currency_type = currency_type
    elsif amount.class == String
      @amount = amount[1..-1].to_f
      @code = symbol_to_code( amount[0] )
    else
      raise StandardError, "Cannot parse inputs."
    end
  end

  def symbol_to_code( symbol )
    code_lookup = {"$" => "USD",
                   "€" => "EUR",
                   "¥" => "JPY",
                   "£" => "GBP"}
    if code_lookup.has_key?(symbol)
      return code_lookup[symbol]
    else
      raise StandardError, "Unknown currency symbol"
      return nil
    end
  end
  #thanks, Christen!!!

  def amount
    @amount
  end
#attr_reader :amount would do the same thing

  def currency_type
    @currency_type
  end

  def tender(currency)
    @currency_type = currency
  end
#attr_writer :currency_type would do the same thing
#dollar.tender(:USD)

  def ==(currency)
    if currency.amount == @amount &&
      currency.currency_type == @currency_type
      true
    else
      false
    end
  end

  def +(other)
    if @currency_type != other.currency_type
      raise DifferentCurrencyCodeError
    end

    self.class.new(amount + other.amount, @currency_type)

  end

  def -(other)
    if @currency_type != other.currency_type
      raise DifferentCurrencyCodeError, "You cannot subtract two different currencies."
    end

    self.class.new(amount - other.amount, @currency_type)

  end

  def *(number)
    product = self.class.new(amount * number, @currency_type)
    return product
  end

end

#dollar1.compare(dollar2)
