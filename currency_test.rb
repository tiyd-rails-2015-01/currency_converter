require 'minitest/autorun'
require 'minitest/pride'
require './currency'

class CurrencyTest < Minitest::Test
  def test_currency_class_exists
    assert Currency
  end

  def test_created_with_amount_and_currency_code
    currency = Currency.new(12, :USD)
    assert currency.amount == 12
    assert currency.currency_code == :USD
  end

  def test_equals_other_object_with_same_amount_and_currency_code
    currency = Currency.new(12, :USD)
    currency1 = Currency.new(12, :USD)
    currency2 = Currency.new(15, :USD)
    currency3 = Currency.new(41, :GBP)
    assert currency.amount == currency1.amount
    refute currency.amount == currency2.amount
    refute currency.amount == currency3.amount
  end
  
  def test_two_objects_with_same_currency_code_can_be_added
    currency1 = Currency.new(12, :USD)
    currency2 = Currency.new(15, :USD)
    currency_total = currency1 + currency2
    assert currency_total.amount == 27
    assert currency_total.currency_code == :USD
  end
end
