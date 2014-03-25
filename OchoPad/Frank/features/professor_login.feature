@simulator_only
Feature: 
	In order to write automated acceptance tests
	As a tester
	I want to be able to login Y2K as a professor

Background:
	Given I launch the app using the ipad simulator
	When I touch the button marked "Professor"
	And I pause briefly for demonstration purposes
	
#Scenario: Touch the UIButton with Label "Professor"
#	Then I wait to see a navigation bar titled "Yearning 2 Know"
#	Then I should see an element of class "UITableView"
#	Then I should see an element of class "UINavigationButton"
#	Then I should see an element of class "UINavigationItemButtonView"
#	And I pause briefly for demonstration purposes
	
#Scenario: Professor should be able to cancel add course action
#	When I touch "Add" if exists
#	And I pause briefly for demonstration purposes
#	When I touch "Cancel" if exists
#	And I pause briefly for demonstration purposes
#	Then I wait to see a navigation bar titled "Yearning 2 Know"
#	Then I should see an element of class "UITableView"
#	Then I should see an element of class "UINavigationButton"
#	Then I should see an element of class "UINavigationItemButtonView"
#	And I pause briefly for demonstration purposes
	
Scenario: Professor should be able to add course
	When I touch "Add" if exists
	And I pause briefly for demonstration purposes
	Then I should see a label with the text "Name"
	Then I should see a label with the text "Number"
	Then I should see a label with the text "Section"
	Then I should see a label with the text "Online Course"
	Then I should see a label with the text "Class Days"
	Then I should see a label with the text "Start Time"
	Then I should see a label with the text "End Time"
	
	# I entered the incorrect course information
	When I type "A" into the text field with label "Name" using keyboard
	When I type "abc" into the text field with label "Number" using keyboard
	When I type "abc" into the text field with label "Section" using keyboard
	
	When I touch "Done" if exists
		Then I wait to see "Name is to Short"
		Then I wait to see "Number must match format: 'EXAM 0000'"
		Then I wait to see "Section must match format: 'A00'"
	
	When I delete 1 characters from the text field with label "Name" using the keyboard
	When I delete 3 characters from the text field with label "Number" using the keyboard
	When I delete 3 characters from the text field with label "Section" using the keyboard
	
	# Now, all the UITextField is empty. We can enter the correct course information now
	When I type "Introduction to Computer Science" into the text field with label "Name" using keyboard
	When I type "Comp 1010" into the text field with label "Number" using keyboard
	When I type "A01" into the text field with label "Section" using keyboard
	
	When I touch "Done" if exists
		And I pause briefly for demonstration purposes
		Then I should see a label with the text "Introduction to Computer Science"
	
	#When I touch the first table cell