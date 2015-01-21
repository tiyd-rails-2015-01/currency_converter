require "pry"

class UnsupportedCurrencyCodeError < StandardError
end

class CurrencyConverter
  attr_reader :conversion_rates

  def initialize( conversion_rates = {  :USD => 1.00,
                                        :EUR => 0.86589,
                                        :GBP => 0.66039,
                                        :INR => 61.7156,
                                        :AUD => 1.22469,
                                        :CAD => 1.21076,
                                        :ZAR => 11.5976,
                                        :NZD => 1.30916,
                                        :JPY => 118.565})
    #conversion rates from USD
    @conversion_rates = conversion_rates
  end

  def convert( currencyObject, toCode )

    # binding.pry

      if @conversion_rates.has_key?(currencyObject.code.to_sym) && @conversion_rates.has_key?(toCode.upcase.to_sym)
        amount = (currencyObject.amount/@conversion_rates[currencyObject.code.to_sym] )*@conversion_rates[toCode.upcase.to_sym]
        code = toCode

        return Currency.new( amount, code )
      else
        raise UnsupportedCurrencyCodeError, "Unsupported currency code"
      end

    end
end
