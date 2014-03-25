# -- See -- #

Then /^I should see a label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UILabel' text:'#{expected_text}'" )
end

Then /^I should see a button label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UIButtonLabel' text:'#{expected_text}'" )
end

# -- misc -- #

When /^I pause briefly for demonstration purposes$/ do
	sleep 1.5
end
