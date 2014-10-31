Feature: Manage users
  In order to be able to manage the users able to use Tracks
  As the administrator of this installed Tracks
  I want to add and delete accounts of users

  Background:
    Given the following user records
      | login    | password | is_admin |
      | testuser | secret   | false    |
      | admin    | secret   | true     |
    And I have logged in as "admin" with password "secret"

  Scenario: Show all accounts
    # TODO

  Scenario: Add new account
    # TODO

  @javascript
  Scenario: Delete account from users page
    When I go to the manage users page
    And I delete the user "testuser"
    Then I should see that a user named "testuser" is not present
