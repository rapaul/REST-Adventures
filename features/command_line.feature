@wip
Feature: Command line
  As a nerdy gamer
  I want to use a command line to explore the dungeon

  Background:
    Given I have a computer with a command line interface

  Scenario: Start the dungeon
    Given there is an entrance described as
      """
      You are in the entrance!
      """
    And a room to the east of the entrance
    When I type the "bin/dungeon" into the command line
    Then the output should be
      """
      You are in the entrance!
      There is a door to the east
      What do you want to do?
      """
