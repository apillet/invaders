class NormalBullet < PlayerBullet
  def initialize(window,x,y, direction = :none)
    super
    @img = Flonkerton::Images[:normal_bullet]
  end

  private

  def speed
    5
  end
end

