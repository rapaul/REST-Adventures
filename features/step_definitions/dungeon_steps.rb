Given /^there is an entrance described as$/ do |description|
  @dungeon = Dungeon.new
  @dungeon.entrance.description = description
  @previous_room = @dungeon.entrance
end

Given /^a room to the east of the entrance described as$/ do |description|
  @previous_room = @previous_room.create_room_to_the_east
  @previous_room.description = description
end

Given /^a room to the east of the entrance$/ do
  @previous_room = @previous_room.create_room_to_the_east
end

Given /^a second room to the south of the first room$/ do
  @previous_room = @previous_room.create_room_to_the_south
end

Given /^a treasure chamber to the west of the second room$/ do
  @previous_room.create_room_to_the_west.designate_as_treasure_chamber
end

module Computer
  def command_line
    @command_line ||= CommandLine.new
  end
end

Given /^I have a computer with a command line interface$/ do
  extend Computer # extend the world with a computer
end

When /^I enter the dungeon$/ do
  @current_room = @dungeon.enter
end

When /^I go east$/ do
  @current_room = @current_room.east
end

When /^I go south$/ do
  @current_room = @current_room.south
end

When /^I go west$/ do
  @current_room = @current_room.west
end

When /^I type the "([^"]*)" into the command line$/ do |command|
  command_line.enter command
end

Then /^I should be in the treasure chamber$/ do
  @current_room.should == @dungeon.treasure_chamber 
end

Then /^the description should be$/ do |description|
  @current_room.description.should == description
end

Then /^the output should be$/ do |output|
  command_line.output.should == output
end
