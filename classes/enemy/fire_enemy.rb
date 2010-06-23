class FireEnemy < Enemy
  def initialize(x_y)
    super
    @width = 26
    @height = 24
    @img = Flonkerton::Images[:fire_enemy]
    @pattern = nil
    @facing = :left
  end

  def shoot
    direction = [:left,:none,:right].shuffle.first
    EnemyFireBullet.new(@x + (@width / 2), @y + @height, direction)
  end

  private

  def movement
    5
  end
end

