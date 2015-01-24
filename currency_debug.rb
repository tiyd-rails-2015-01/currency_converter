require './different_currency_code_error'
require 'pry'
require './currency_converter'


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
      @code = new_hash[sign]
      binding.pry
      if sign == "A" || sign == "C"
        @amount = string[2..-1].to_f
      else
        @amount = string[1..-1].to_f
      end
    end

    # def read_currency_symbol(string)
    #   if the string includes a recognized symbol
    #     match that symbol with appropriate code from hash
    #     return correct currency code
    #   else the string has an odd symbol or no symbol
    #     raise UnknownCurrencyCodeError
    #   end
    # end


    #start_with?  looping over hash (hash.each) and then, split on that thing and take the number out
    #"$32"[1..-1].to_f gives 32.0

  end


  # money_machine = CurrencyConverter.new()
  # my_money = Currency.new("$10.00")
  # # their_money = Currency.new("£10.00")
  # changed_money = money_machine.convert(my_money, :GBP)
  #
  # puts "apricot #{changed_money}"
  # different_money = money_machine.convert(their_money, :JPY)
