Feature: Admin Deletes any Resource

  Background:
    Given an admin account exists
    And a second user account exists
    And the second user creates a resource
    And I login as an admin
  @javascript
  Scenario: An admin can delete any resource from the resource index page
    When I go to the resources index page
    When I delete the second user's resource
    Then I should be on the resources index page
    And the second user's resource should no longer be displayed