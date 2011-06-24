Feature: Dungeon
  As an old-school gamer 
  I want a dungeon adventure
  
  Background: A horseshoe dungeon
    Given there is an entrance described as
      """
      You are in the entrance!
      """
    And a room to the east of the entrance described as
      """
      A dark and gloomy room, ooh!
      """
    And a second room to the south of the first room
    And a treasure chamber to the west of the second room
  
  Scenario: Explore dungeon
    When I enter the dungeon
    And I go east
    And I go south
    And I go west
    Then I should be in the treasure chamber

  Scenario: Describe entrance
    When I enter the dungeon
    Then the description should be
      """
      You are in the entrance!
      """
    
  Scenario: Describe a second room
    When I enter the dungeon
    And I go east
    Then the description should be
      """
      A dark and gloomy room, ooh!
      """
  
  
  
    