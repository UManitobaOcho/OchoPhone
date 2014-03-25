@simulator_only
Feature: 
	In order to write automated acceptance tests
	As a tester
	I want to be able to login Y2K as a professor

Background:
	Given I launch the app using the ipad simulator
	When I touch the button marked "Professor"
	And I pause briefly for demonstration purposes
	
Scenario: Touch the UIButton with Label "Professor"
	Then I wait to see a navigation bar titled "Yearning 2 Know"
	Then I should see an element of class "UITableView"
	Then I should see an element of class "UINavigationButton"
	Then I should see an element of class "UINavigationItemButtonView"

Scenario: Professor should be able to cancel add course action
	When I touch "Add" if exists
	And I pause briefly for demonstration purposes
	When I touch "Cancel" if exists
	And I pause briefly for demonstration purposes
	Then I wait to see a navigation bar titled "Yearning 2 Know"
	Then I should see an element of class "UITableView"
	Then I should see an element of class "UINavigationButton"
	Then I should see an element of class "UINavigationItemButtonView"
	
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
	


	
	