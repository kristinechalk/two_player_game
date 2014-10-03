class Player

  attr_accessor :name, :lives, :points

  def initialize(name)
    @name = name
    @lives = 3
    @points = 0
  end

end
