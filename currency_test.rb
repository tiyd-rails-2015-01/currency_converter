require 'minitest/autorun'
require 'minitest/pride'
require './currency'
require './currency_converter'


class CurrencyTest <Minitest::Test
  def test_currency_class_exists
    assert Currency
  end

  def test_currency_class_takes_two_parameters
    assert Currency.new("", "")
  end

  def test_two_currency_objects_are_equivalent
    my_dollar = Currency.new(1, "USD")
    your_dollar = Currency.new(1, "USD")
    his_dollar = Currency.new(5, "EUR")
    her_dollar = Currency.new(2, "EUR")
    assert my_dollar == your_dollar
    refute his_dollar == her_dollar
  end

  def test_add_two_currency_objects
    my_money = Currency.new(5, "USD")
    your_money = Currency.new(10, "USD")
    assert my_money + your_money == Currency.new(15, "USD")
  end

  def test_subtract_two_currency_objects
    my_money = Currency.new(20, "USD")
    your_money = Currency.new(5, "USD")
    assert my_money - your_money == Currency.new(15, "USD")
  end

  def test_combining_mismatched_currencies_raises_error
    my_money = Currency.new(15, "USD")
    your_money = Currency.new(25, "GBP")
    assert_raises(DifferentCurrencyCodeError) {my_money + your_money}
    assert_raises(DifferentCurrencyCodeError) {my_money - your_money}
  end

  def test_can_multiply_by_float_or_fixnum
    my_money = Currency.new(10, "USD")
    assert (my_money * 8) == Currency.new(80, "USD")
    assert (my_money * 2.5) == Currency.new(25, "USD")
    refute (my_money * 7) == Currency.new(7000, "USD")
  end

  def test_currency_converter_class_exists
    assert CurrencyConverter
  end

  def show_currency_rates
    return {USD: 1.00000,
      EUR: 0.86384,
      GBP: 0.66054,
      AUD: 1.23455,
      CAD: 1.23290,
      JPY: 117.874}
  end

  def test_currency_converter_initializes_with_hash
    @currency_rates = show_currency_rates
    money_machine = CurrencyConverter.new(@currency_rates)
    different_currencies = money_machine.currency_rates
    assert_equal Hash, different_currencies.class
  end

  def test_currency_converter_converts_same_currency_type
    money_machine = CurrencyConverter.new(@currency_rates)
    new_money = Currency.new(1, :USD)
    newest_money = money_machine.convert(new_money, :USD)
    assert_equal Currency.new(1, :USD), newest_money
    refute Currency.new(2, :USD) == newest_money
    refute Currency.new(1, :EUR) == newest_money
  end

  #for fun: currency rate table in own file
  # decimal place display
  #what about situations where this would be a negative #? $ doesn't work that way
end
