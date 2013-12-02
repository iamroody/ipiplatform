Feature: Admin Edits any Resource

  Background:
    Given an admin account exists
    And a second user account exists
    And the second user creates a resource
    And I login as an admin

  @javascript
  Scenario: An admin can edit any resource from the resource index page
    When I go to the resources index page
    Then the second user's edit resource button is visible
#    When I click the "Edit this Resource" button
#    And I change the resource name
#    And I submit the resource
#    Then I see the resource's new name
#    And I see a notification that the resource was updated
#    And I am on the resources show page

