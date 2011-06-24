class Dungeon
  def initialize
    @entrance = Room.new(self, "You are in the entrance")
  end

  def enter
    @entrance 
  end
  
  attr_reader :entrance
  attr_accessor :treasure_chamber
end


class Room
  def initialize(dungeon, description = "")
    @dungeon = dungeon
    @description = description
  end
  
  attr_accessor :description
  
  
  [:north, :south, :east, :west].each do |direction|
    define_method "create_room_to_the_#{direction}" do
      instance_variable_set "@#{direction}", Room.new(@dungeon)
    end
    
    attr_reader direction
  end
  
  def designate_as_treasure_chamber
    @dungeon.treasure_chamber = self
  end
end


Given /^there is an entrance described as$/ do |description|
  @dungeon = Dungeon.new
  @dungeon.entrance.description = description
  @previous_room = @dungeon.entrance
end

Given /^a room to the east of the entrance described as$/ do |description|
  @previous_room = @previous_room.create_room_to_the_east
  @previous_room.description = description
end

Given /^a second room to the south of the first room$/ do
  @previous_room = @previous_room.create_room_to_the_south
end

Given /^a treasure chamber to the west of the second room$/ do
  @previous_room.create_room_to_the_west.designate_as_treasure_chamber
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

Then /^I should be in the treasure chamber$/ do
  @current_room.should == @dungeon.treasure_chamber 
end

Then /^the description should be$/ do |description|
  @current_room.description.should == description
end

