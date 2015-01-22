require 'minitest/autorun'
require 'minitest/pride'

require './currency.rb'
require './different_currency_code_error.rb'
require './currency_converter.rb'

class CurrencyTest < Minitest::Test
  def test_currency_exists
    assert Currency
  end

  def test_currency_can_be_created
    assert Currency.new(1, :USD)
  end

  def test_currency_can_be_created_and_retrieved
    currency = Currency.new(3, :USD)
    assert_equal 3, currency.amount
    assert_equal :USD, currency.currency_type
  end

  def test_equals_another_currency_object
    amount_1 = Currency.new(5, :USD)
    amount_2 = Currency.new(5, :USD)
    assert amount_1 == amount_2
  end

  def test_add_currency_objects_with_same_code
    amount_1 = Currency.new(5, :USD)
    amount_2 = Currency.new(10, :USD)
    amount_3 = Currency.new((5 + 10), :USD)
    amount_4 = amount_1 + amount_2
    assert_equal amount_3, amount_4
  end

  def test_add_currency_with_different_code
    currency_1 = Currency.new(5, :USD)
    currency_2 = Currency.new(10, :GBP)
    assert_raises(DifferentCurrencyCodeError) { currency_1 + currency_2 }
  end

  def test_subtract_currency_with_different_code
    currency_1 = Currency.new(5, :USD)
    currency_2 = Currency.new(10, :GBP)
    assert_raises(DifferentCurrencyCodeError) { currency_1 - currency_2 }
  end

  def test_multiply_and_return_currency_object
    currency_1 = Currency.new(5, :USD)

    currency_2 = Currency.new(10, :USD)
    currency_3 = currency_1 * 2
    assert_equal currency_3, currency_2

    currency_4 = currency_1 * 1.75
    currency_5 = Currency.new(8.75, :USD)
    assert_equal currency_4, currency_5
  end

  def test_currency_converter_exists
    assert CurrencyConverter
  end

  def test_is_hash_created
    assert CurrencyConverter.new({USD: 1.0, EUR: 0.86})
  end

  def test_convert_to_same_currency_type
    money = CurrencyConverter.new({USD: 1.0, EUR: 0.86})
    new_currency = Currency.new(1, :USD)
    newer_currency = money.convert(new_currency, :USD)
    assert_equal Currency.new(1, :USD), newer_currency
  end

  def test_convert_to_different_currency_types
    money = CurrencyConverter.new({USD: 1.0, EUR: 0.86})

    new_currency = Currency.new(1, :USD)
    newer_currency = money.convert(new_currency, :EUR)
    assert_equal Currency.new(0.86, :EUR), newer_currency

    one_euro = Currency.new(1, :EUR)
    dollars = money.convert(one_euro, :USD)
    assert_equal Currency.new(1.1627906976744187, :USD), dollars
  end

end


# def +(other)
#   Number.new(amount + other.amount)
# end
#
# when you type 2 + 2 in irb
#   under the hood
# 2.+(2) is what happens
# 2.==(3)
# fixnum has a class (==) and it's calling 3 on it

#you have to define a + method

# Class Number
# attr_reader :amount
#
#   def initialize(amt)
#     @amount = amt
#   end
#
#   def +(other)
#     amount + other.amount
#   end
#
#   def ==(other)
#     #we want this method to either return a true or false
#     amount == other.amount #will return true if amounts are the same
#   end

# end
