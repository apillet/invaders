class EnemyBullet < Bullet
  def initialize(window,x,y,direction = :none)
    super
    @img = Gosu::Image.new(@window, "media/enemy_bullet.png", true)
  end

  def move
    @y += speed
    destroy if @y >= @window.height
  end

  private

  def speed
    5
  end

end

