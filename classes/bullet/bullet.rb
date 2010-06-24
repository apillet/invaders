class Bullet
  attr_reader :x, :y, :power
  @@bullets = Array.new
  def initialize(x,y,direction = :none)
    @x, @y = x, y
    @width, @height = 3, 6
    @direction = direction
    @power = 1
    @@bullets << self
    @img = nil
  end

  def move
    @y -= speed
    case @direction
    when :left then
      @x -= speed / 2
    when :right then
      @x += speed / 2
    when :none then
    end
    destroy if @y <= 0
  end

  def draw
    @img.draw :x => @x,
              :y => @y,
              :z => 1
  end

  def destroy
    @@bullets.delete self
  end

  def collides?(player)
    @x >= player.x and @x <= player.x + player.width and @y >= player.y and @y <= player.y + player.height
  end

  def self.move_all
    @@bullets.each do |bullet|
      bullet.move
    end
  end

  def self.draw_all
    @@bullets.each do |bonus|
      bonus.draw
    end
  end

  def self.all
    @@bullets
  end

  private

  def speed
    raise NotImplementedError
  end

end

