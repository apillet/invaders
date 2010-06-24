class PlayerBullet < Bullet
  @@player_bullets = []
  def initialize(x,y, direction = :none)
    super
    @@player_bullets << self
  end

  def collides?(enemy)
    if @x >= enemy.x and @x <= enemy.x + enemy.width then
      if @y >= enemy.y and @y <= enemy.y + enemy.height then
        true
      end
    else
      false
    end
  end

  def self.all
    @@player_bullets
  end

end

