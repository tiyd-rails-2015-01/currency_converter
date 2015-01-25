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

  def test_should_equal_other_object_with_same_amount_and_currency_code
    currency = Currency.new(12, :USD)
    currency1 = Currency.new(12, :USD)
    assert currency.amount == currency1.amount
  end
end
