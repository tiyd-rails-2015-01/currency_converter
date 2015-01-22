require 'minitest/autorun'
require 'minitest/pride'
require './currency.rb'
require './currency_converter.rb'
require './currency_trader.rb'

# Day 1 Requirements:

# Currency:
#
# * Should be created with an amount and a currency code
# * Should equal another Currency object with the same amount and currency code
# * Should be able to be added to another Currency object with the same currency code
# * Should be able to be subtracted by another Currency object with the same currency code
# * Should raise a DifferentCurrencyCodeError when you try to add or subtract two Currency objects with different currency codes.
# * Should be able to be multiplied by a Fixnum or Float and return a Currency object

#/-----------------------------------------------
# Day Two Requirements:

# CurrencyConverter:
#
# Should be initialized with a Hash of currency codes to conversion rates (see link to rates below)
# At first, just make this work with two currency codes and conversation rates, with one rate being
# 1.0 and the other being the conversation rate. An example would be this: {USD: 1.0, EUR: 0.74},
# which implies that a dollar is worth 0.74 euros.
# Should be able to take a Currency object and a requested currency code that is the same currency
# code as the Currency object's and return a Currency object equal to the one passed in (that is,
# currency_converter.convert(Currency.new(1, :USD), :USD) == Currency.new(1, :USD))
# Should be able to take a Currency object that has one currency code it knows and a requested
# currency code and return a new Currency object with the right amount in the new currency code
# Should be able to be created with a Hash of three or more currency codes and conversion rates.
# An example would be this: {USD: 1.0, EUR: 0.74, JPY: 120.0}, which implies that a dollar is
# worth 0.74 euros and that a dollar is worth 120 yen, but also that a euro is worth 120/0.74 =
# 162.2 yen.
# Should be able to convert Currency in any currency code it knows about to Currency in any other
# currency code it knows about.
# Should raise an UnknownCurrencyCodeError when you try to convert from or to a currency code it
# doesn't know about.
#
# Currency (modifications to earlier code):
#
# Currency.new should be able to take one argument with a currency symbol embedded in it, like
# "$1.20" or "€ 7.00", and figure out the correct currency code. It can also take two arguments
# like before, one being the amount and the other being the currency code.

class CurrencyTest < Minitest::Test

  def test_currency_initialize_with_two_parameters
    assert Currency.new( 1.00, "USD")
  end

  def test_currency_initialize_with_one_parameter
    assert Currency.new("$1.20")
    assert Currency.new("€ 7.00")

    assert_equal "USD", Currency.new("$1.20").code
  end

  def test_currency_objects_are_equal
    dollar1 = Currency.new( 1.00, "USD")
    dollar2 = Currency.new( 1.00, "USD")

    assert_equal dollar1, dollar2
  end

  def test_addition
    dollar1 = Currency.new( 1.00, "USD")
    dollar2 = Currency.new( 1.00, "USD")

    assert_equal 2, (dollar1 + dollar2).amount
    assert_equal "USD", (dollar1 + dollar2).code
  end

  def test_subtraction
    dollar1 = Currency.new( 2.00, "USD")
    dollar2 = Currency.new( 1.00, "USD")

    assert_equal 1, (dollar1 - dollar2).amount
    assert_equal "USD", (dollar1 - dollar2).code
  end

  # def test_adding_and_subtracting_with_different_currency_codes
  #   dollar = Currency.new( 1.00, "USD")
  #   euro = Currency.new( 1.00, "EUR")
  #
  #   assert_raises( DifferentCurrencyCodeError ) do
  #     dollar + euro
  #   end
  #
  #   assert_raises( DifferentCurrencyCodeError) do
  #     dollar - euro
  #   end
  # end

  def test_multiplication
    dollar = Currency.new( 2.00, "USD" )
    float = 2.0
    fixnum = 4

    assert_equal 4.00, (dollar * float).amount
    assert_equal 8.00, (dollar * fixnum).amount

  end

  def test_addition_of_different_currencies
    dollar1 = Currency.new( 1.00, "USD")
    euro1 = Currency.new( 0.86589, "EUR")

    fake = Currency.new( 1.00, "OMG")

    assert_equal 2, (dollar1 + euro1).amount

    assert_raises( UnknownCurrencyCodeError) do
      dollar1 + fake
    end

    assert_raises( UnknownCurrencyCodeError) do
      fake + euro1
    end
  end

  def test_subtraction_of_different_currencies
    dollar1 = Currency.new( 2.00, "USD")
    euro1 = Currency.new( 0.86589, "EUR")

    fake = Currency.new( 1.00, "OMG")

    assert_equal 1, (dollar1 - euro1).amount

    assert_raises( UnknownCurrencyCodeError) do
      dollar1 - fake
    end

    assert_raises( UnknownCurrencyCodeError) do
      fake - euro1
    end
  end

  def test_currency_converter_initialized_with_conversion_rates
    converter = CurrencyConverter.new
    assert_equal Hash, converter.conversion_rates.class
  end

  def test_convert_to_same_currency_code
    currency_converter = CurrencyConverter.new
    assert_equal currency_converter.convert(Currency.new(1, "USD"), "USD"), Currency.new(1, "USD")
  end

  def test_convert_to_different_currency_code
    currency_converter = CurrencyConverter.new
    assert_equal currency_converter.convert(Currency.new(1, "USD"), "GBP"), Currency.new(0.66039, "GBP")
  end

  def test_initialize_currency_converter_with_hash
    hash = {USD: 1.0, EUR: 0.74, JPY: 120.0}
    assert converter = CurrencyConverter.new(hash)

    assert_equal 0.74, converter.convert(Currency.new(1,"USD"),"EUR").amount.round(2)
    assert_equal 162.2, converter.convert(Currency.new(1,"EUR"),"JPY").amount.round(1)
  end

  def test_initialize_currencytrader
    hash1 = {USD: 1.0, EUR: 0.74, JPY: 120.0}
    hash2 = {USD: 1.2, EUR: 1, JPY: 110.0}

    exchangeRatesOverTime = [CurrencyConverter.new(hash1), CurrencyConverter.new(hash2)]
    
    startingCurrency = Currency.new( 1.00, "USD")
    assert CurrencyTrader.new( exchangeRatesOverTime, startingCurrency)
  end

end
