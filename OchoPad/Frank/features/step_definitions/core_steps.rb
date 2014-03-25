# -- See -- #

Then /^I should see a label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UILabel' text:'#{expected_text}'" )
end

Then /^I should see a button label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UIButtonLabel' text:'#{expected_text}'" )
end

# -- touch -- #

# -- input -- #

When /^I type "([^"]*)" into the text field with label "([^"]*)" using keyboard$/ do |input_text, mark|
	quote = get_selector_quote(mark)
	selector = "textField marked:#{quote}#{mark}#{quote} first"
	if element_exists(selector)
		touch( selector )
	else
		raise "Could not touch [#{mark}], it does not exist."
	end
	sleep 0.5 # wait for keyboard to animate in
	type_into_keyboard( input_text )
end

When /^I delete (\d+) characters from the text field with label "([^"]*)" using the keyboard$/ do |num_delete, mark|
	num_deletes = num_delete.to_i
	input_text = "\b"*num_deletes
	
	quote = get_selector_quote(mark)
	selector = "textField marked:#{quote}#{mark}#{quote} first"
	if element_exists(selector)
		touch( selector )
	else
		raise "Could not touch [#{mark}], it does not exist."
	end
	
	sleep 0.5 # wait for keyboard to animate in
	type_into_keyboard( input_text )
end

# -- misc -- #

When /^I pause briefly for demonstration purposes$/ do
	sleep 1.5
end
