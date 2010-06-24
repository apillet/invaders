class Bonus
  attr_reader :x, :y, :width, :height, :perk, :duration
  @@bonuses = Array.new
  def initialize
    @x = rand(Flonkerton::CONFIG[:width])
    @y = -10
    @width, @height = 5,5
    @perk = nil
    @duration = 4
    @@bonuses << self
  end

  def move
    @y += speed
    destroy if @x <= 0
  end

  def draw
    @img.draw :x => @x,
              :y => @y,
              :z => 1
  end

  def destroy
    @@bonuses.delete self
  end

  def collides?(player)
    @x >= player.x and @x <= player.x + player.width and @y >= player.y and @y <= player.y + player.height
  end

  def self.move_all
    @@bonuses.each do |bonus|
      bonus.move
    end
  end

  def self.draw_all
    @@bonuses.each do |bonus|
      bonus.draw
    end
  end

  def self.all
    @@bonuses
  end

  private

  def speed
    raise NotImplementedError
  end
end
