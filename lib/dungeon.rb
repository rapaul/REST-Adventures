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

class CommandLine

  def enter(command)
    @io = IO::popen(command)
  end

  def output
    @io.read
  end
end
