require './different_currency_code_error'


class Currency
  attr_reader :amount, :code, :string
  def initialize(amount_or_string, code=nil)
    if code
      @amount = amount_or_string
      @code = code
    else
      @string = amount_or_string
      read(@string)
    end
  end

  def symbols
    {USD: "$",
      EUR: "€",
      GBP: "£",
      AUD: "A$",
      CAD: "C$",
      JPY: "¥"}
  end

  def read(string)
    sign = string[0]
    new_hash = symbols.invert
    if sign == "A" || sign == "C"
      @amount = string[2..-1].to_f
      @code = new_hash[(string[0..1])]
    else
      @amount = string[1..-1].to_f
      @code = new_hash[sign]
    end
  end

  def ==(other_money)
    self.amount == other_money.amount && self.code == other_money.code
  end

  def +(other_money)
    if self.code == other_money.code
      Currency.new(amount + other_money.amount, code)
    else
      raise DifferentCurrencyCodeError, "You cannot add two different kinds of currency"
    end
  end

  def -(other_money)
    if self.code == other_money.code
      Currency.new(amount - other_money.amount, code)
    else
      raise DifferentCurrencyCodeError, "You cannot subtract two different kinds of currency."
    end
  end

  def *(number)
    Currency.new(amount * number, code)
  end

end
