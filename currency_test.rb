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
    assert (my_money * 2.55) == Currency.new(25.5, "USD")
    refute (my_money * 7) == Currency.new(7000, "USD")
  end

  def test_currency_converter_class_exists
    assert CurrencyConverter
  end

  def currency_rates
    return {USD: 1.00000,
      EUR: 0.88949,
      GBP: 0.66591,
      AUD: 1.26142,
      CAD: 1.24298,
      JPY: 117.774}
  end

  def test_currency_converter_initializes_with_hash
    money_machine = CurrencyConverter.new(currency_rates)
    different_currencies = money_machine.currency_codes
    assert_equal currency_rates, different_currencies
  end

  def test_currency_converter_converts_same_currency_type
    money_machine = CurrencyConverter.new(currency_rates)
    new_money = Currency.new(1, :USD)
    newest_money = money_machine.convert(new_money, :USD)
    assert_equal Currency.new(1, :USD), newest_money
    refute Currency.new(2, :USD) == newest_money
    refute Currency.new(1, :EUR) == newest_money
  end

  def test_currency_converter_converts_from_usd_to_another_type
    money_machine = CurrencyConverter.new()
    my_money = Currency.new(5, :USD)
    changed_money = money_machine.convert(my_money, :EUR)
    assert_equal Currency.new(4.3192, :EUR), changed_money
  end

  def test_currency_converter_converts_different_currency_types
    money_machine = CurrencyConverter.new()
    my_money = Currency.new(10, :EUR)
    changed_money = money_machine.convert(my_money, :GBP)
    different_money = money_machine.convert(my_money, :JPY)
    assert_in_delta Currency.new(7.65, :GBP).amount, changed_money.amount, 0.01
    assert_in_delta Currency.new(1364.54, :JPY).amount, different_money.amount, 0.01
  end

  def test_currency_converter_raises_error_with_unknown_currency
    money_machine = CurrencyConverter.new(currency_rates)
    my_money = Currency.new(10, :BRL)
    assert_raises(UnknownCurrencyCodeError) {money_machine.convert(my_money, :USD)}
  end

  def test_currency_symbol_reader
    money_machine = CurrencyConverter.new(currency_rates)
    my_money = Currency.new("$10.00")
    their_money = Currency.new("£10.00")
    changed_money = money_machine.convert(my_money, :GBP)
    different_money = money_machine.convert(their_money, :JPY)
    assert_in_delta Currency.new(6.66, :GBP).amount, changed_money.amount, 0.01
    assert_in_delta Currency.new(1768.62, :JPY).amount, different_money.amount, 0.01
  end

  # def test_converter_can_read_symbols
  # end


  # decimal place display
  # return currency with symbol

end
