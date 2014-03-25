# -- See -- #

Then /^I should see a label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UILabel' text:'#{expected_text}'" )
end

Then /^I should see a button label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UIButtonLabel' text:'#{expected_text}'" )
end

Then /^I should see a table view label with the text "([^"]*)"$/ do |expected_text|
	check_element_exists( "view:'UITableViewLabel' text:'#{expected_text}'" )
end

Then /^I wait to see a label marked "([^"]*)"$/ do |expected_mark|
  quote = get_selector_quote(expected_mark)
  wait_until( :timeout => 30, :message => "waited to see a label marked #{quote}#{expected_mark}#{quote}" ) {
    element_exists( "UILabel marked:#{quote}#{expected_mark}#{quote}" )
  }
end


# -- touch -- #

# table cells
When /^I touch the table cell with label marked "([^"]*)"$/ do |mark|
	quote = get_selector_quote(mark)
	touch("tableViewCell label marked:#{quote}#{mark}#{quote}")
end

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

When /^I type "([^"]*)" into the "([^"]*)" text field using the keyboard$/ do |text_to_type, placeholder|
  touch( "textField placeholder:'#{placeholder}'" )
  sleep 0.5 # wait for keyboard to animate in
  type_into_keyboard( text_to_type )
end

When /^I delete (\d+) characters from the "(.*?)" text field using the keyboard$/ do |num_deletes, placeholder|
  num_deletes = num_deletes.to_i
  text_to_type = "\b"*num_deletes

  touch( "textField placeholder:'#{placeholder}'" )
  sleep 0.5 # wait for keyboard to animate in
  wait_for_nothing_to_be_animating
  type_into_keyboard( text_to_type )
end

# -- misc -- #

When /^I pause briefly for demonstration purposes$/ do
	sleep 1.5
end
