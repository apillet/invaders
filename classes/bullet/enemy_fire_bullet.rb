class EnemyFireBullet < Bullet
  def initialize(window,x,y,direction = :none)
    super
    @width, @height = 5, 7
    @img = Flonkerton::Images[:enemy_fire_bullet]
  end

  def move
    @y += speed
    case @direction
    when :left then
      @x -= speed / 4
    when :right then
      @x += speed / 4
    when :none then
    end
    destroy if @y >= @window.height
  end

  private

  def speed
    8
  end

end

