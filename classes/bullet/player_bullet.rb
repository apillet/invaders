class PlayerBullet < Bullet
  @@player_bullets = []
  def initialize(x,y, direction = :none)
    super
    @@player_bullets << self
  end

  def collides?(enemy)
    @x >= enemy.x and @x <= enemy.x + enemy.width and @y >= enemy.y and @y <= enemy.y + enemy.height
  end

  def self.all
    @@player_bullets
  end
end
