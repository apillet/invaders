class EnemyBullet < Bullet
  def initialize(x,y,direction = :none)
    super
    @img = Flonkerton::Images[:enemy_bullet]
  end

  def move
    @y += speed
    destroy if @y >= Flonkerton::CONFIG[:height]
  end

  private

  def speed
    5
  end

end

