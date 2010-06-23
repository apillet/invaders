class NormalBullet < PlayerBullet
  def initialize(x,y, direction = :none)
    super
    @img = Flonkerton::Images[:normal_bullet]
  end

  private

  def speed
    5
  end
end

