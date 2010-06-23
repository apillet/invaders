class EnemyBullet < Bullet
  def initialize(window,x,y,direction = :none)
    super
    @img = Flonkerton::Images[:enemy_bullet]
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

