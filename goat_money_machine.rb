require './different_currency_code_error'
require './unknown_currency_code_error'
require './currency'
require './currency_converter'


def change_real_money(mm)
  array = mm.symbols.invert.keys
  symbols_to_show = array.reduce(' ') {|start, each| start += each.to_s + '  '}
  #this lovely reduce business comes courtesy of Michael Byrd
  puts "How much money do you have? Please enter it with the proper symbol, e.g. $10.00.\nChoose from the following:#{symbols_to_show}"
  input = gets.chomp
  correct_input = false
  while correct_input == false && input != nil
    if array.include?(input[0])
      correct_input = true
      cash = input
    else
      puts "Please enter a value with the correct symbol."
      correct_input = false
      input = gets.chomp
    end
  end
  my_money = Currency.new(cash)
  symbol_array = mm.currency_codes.keys
  displayable_keys = symbol_array.reduce('| ') {|start, each| start += each.to_s + ' | '}
  #this lovely reduce business comes courtesy of Michael Byrd
  puts "What kind of money do you need? Please choose from the following codes: \n#{displayable_keys}"
  code_input = gets.chomp.to_sym
  right_input = false
  while right_input == false && code_input != nil
    if mm.valid_currency_code?(code_input)
      right_input = true
      other_money = code_input
    else
      puts "Please enter one of the available codes."
      right_input = false
      code_input = gets.chomp.to_sym
    end
  end
  puts mm.change_my_money(my_money, other_money)
end

money_machine = CurrencyConverter.new()
new_money = change_real_money(money_machine)
print new_money
