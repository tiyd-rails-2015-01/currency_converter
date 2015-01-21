class DifferentCurrencyCodeError < StandardError
end

class Currency

  attr_reader :amount, :code

  def initialize( amount, code )
    #using currency codes as listed here: http://en.wikipedia.org/wiki/ISO_4217
    # quick reference:  EUR = euro
    # =>                GBP = pounds sterling
    # =>                USD = US dollars
    @amount = amount
    @code = code
  end

  # def convert( toCode )
  #   #convert to currency of type code
  #   conversion_rates_from_usd = { :usd => 1.00,
  #                                 :eur => 0.86589,
  #                                 :gbp => 0.66039,
  #                                 :inr => 61.7156,
  #                                 :aud => 1.22469,
  #                                 :cad => 1.21076,
  #                                 :zar => 11.5976,
  #                                 :nzd => 1.30916,
  #                                 :jpy => 118.565}
  #                                 #usd / 1 = eur / 0.86
  #   if conversion_rates_from_usd.has_key?(@code.downcase.to_sym) && conversion_rates_from_usd.has_key?(toCode.downcase.to_sym)
  #     @amount = (@amount/conversion_rates_from_usd[@code.downcase.to_sym] )*conversion_rates_from_usd[toCode.downcase.to_sym]
  #     @code = toCode
  #   else
  #     raise UnsupportedCurrencyCodeError, "That currency code is not currently supported"
  #   end
  # end

  def ==( otherCurrencyObject)
    if @amount == otherCurrencyObject.amount && @code == otherCurrencyObject.code
      return true
    else
      return false
    end
  end

  def +( otherCurrencyObject )
    if @code == otherCurrencyObject.code
      return self.class.new(@amount + otherCurrencyObject.amount, @code)
    else
      #error!
      raise DifferentCurrencyCodeError, "Can only subtract currencies with the same currency code"
      return nil
      # otherCurrencyObject.convert(@code)
      # return self.class.new(@amount + otherCurrencyObject.amount, @code)
    end
  end

  def -( otherCurrencyObject )
    if @code == otherCurrencyObject.code
      return self.class.new(@amount - otherCurrencyObject.amount, @code)
    else
      #error!
      raise DifferentCurrencyCodeError, "Can only subtract currencies with the same currency code"
      return nil
      # otherCurrencyObject.convert(@code)
      # return self.class.new(@amount - otherCurrencyObject.amount, @code)
    end
  end

  def *( number )
    return self.class.new( @amount * number, @code )
  end

end
