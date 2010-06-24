class FireEnemy < Enemy
  def initialize(x_y)
    super
    @img = Flonkerton::Images[:fire_enemy]
    @width = @img.width
    @height = @img.height
    @facing = :left
  end

  def shoot
    direction = [:left, :none, :right].sample
    EnemyFireBullet.new(@x + (@width / 2), @y + @height, direction)
  end

  private

  def movement
    5
  end
end

