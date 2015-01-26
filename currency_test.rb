require 'minitest/autorun'
require 'minitest/pride'
require './currency'
require './currency_converter'
require './different_currency_code_error'

class CurrencyTest < Minitest::Test
  def test_currency_class_exists
    assert Currency
  end

  def test_created_with_amount_and_currency_code
    currency = Currency.new(15, :USD)
    assert currency.amount == 15
    assert currency.currency_code == :USD
  end

  def test_equals_other_object_with_same_amount_and_currency_code
    currency = Currency.new(15, :USD)
    currency1 = Currency.new(15, :USD)
    currency2 = Currency.new(12, :USD)
    currency3 = Currency.new(41, :GBP)
    assert currency.amount == currency1.amount
    refute currency.amount == currency2.amount
    refute currency.amount == currency3.amount
  end

  def test_two_objects_with_same_currency_code_can_be_added
    currency1 = Currency.new(15, :USD)
    currency2 = Currency.new(12, :USD)
    currency3 = Currency.new(41, :GBP)
    currency_total = currency1 + currency2
    assert currency_total.amount == 27
    assert currency_total.currency_code == :USD
    assert_raises DifferentCurrencyCodeError do
      currency2 + currency3
    end
  end

  def test_two_objects_with_same_currency_code_can_be_subtracted
    currency1 = Currency.new(15, :USD)
    currency2 = Currency.new(12, :USD)
    currency3 = Currency.new(41, :GBP)
    currency_total1 = currency1 - currency2
    assert currency_total1.amount == 3
    assert currency_total1.currency_code == :USD
    assert_raises DifferentCurrencyCodeError do
      currency2 - currency3
    end
  end

  def test_currency_can_be_multiplied_by_a_fixnum_or_float
    currency2 = Currency.new(12, :USD)
    assert currency2 * 10 == Currency.new(120, :USD)
    assert currency2 * 2.5 == Currency.new(30, :USD)
  end

  def test_currency_converter_class_exists
    assert CurrencyConverter
  end

  def test_initializes_with_hash_of_currency_codes_and_conversion_rates
    currencies = ({USD: 1.0, EUR: 0.87})
    CurrencyConverter.new(currencies)
  end

  def test_currency_objects_are_equal
    currency1 = Currency.new(15, :USD)
    currencies = CurrencyConverter.new({USD: 1.0, EUR: 0.87})
    currencies.convert(currency1, :USD) == Currency.new(15, :USD)
  end

  def test_convert_from_one_currency_to_another
    currency1 = Currency.new(15, :USD)
    currencies = CurrencyConverter.new({USD: 1.0, EUR: 0.87})
    currencies.convert(currency1, :EUR) == Currency.new(13.05, :EUR)
  end

  def test_initializes_with_hash_of_three_currency_codes_and_conversion_rates
    currencies1 = ({USD: 1.0, EUR: 0.87, GBP: 0.67})
    CurrencyConverter.new(currencies1)
  end
end
