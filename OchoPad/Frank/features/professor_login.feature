@simulator_only
Feature: 
	In order to write automated acceptance tests
	As a tester
	I want to be able to login Y2K as a professor

Background:
	Given I launch the app using the ipad simulator
	
Scenario: Touch the UIButton with Label "Professor"
	When I touch the button marked "Professor"
	Then I should see a navigation bar titled "Yearning 2 Know"

Given I quit the simulator
