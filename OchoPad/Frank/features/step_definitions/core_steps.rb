# -- See -- #

Then /^I should see a label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UILabel' text:'#{expected_text}'" )
end

Then /^I should see a button label with the text "([^"]*)"$/ do |expected_text|
  	check_element_exists( "view:'UIButtonLabel' text:'#{expected_text}'" )
end

# -- touch -- #
When /^I touch the navigation button marked "([^"]*)"$/ do |mark|
	quote = get_selector_quote(mark)
  	touch("navigationButton marked:#{quote}#{mark}#{quote}")
end

# -- misc -- #

When /^I pause briefly for demonstration purposes$/ do
	sleep 1.5
end
