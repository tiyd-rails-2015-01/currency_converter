require './different_currency_code_error'
require './unknown_currency_code_error'
require './currency'
require './currency_converter'

money_machine = CurrencyConverter.new()
my_money = Currency.new("$10.00")
# goat_money = money_machine.convert(my_money, :AUD)
# puts goat_money.amount
puts money_machine.change_my_money(my_money, :AUD)

#Gets, chomp
