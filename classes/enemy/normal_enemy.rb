 class NormalEnemy < Enemy

  def initialize(x_y)
    super
    @img = Flonkerton::Images[:normal_enemy]
    @width = @img.width
    @height = @img.height
    @facing = :right
  end

  private

  def movement
    5
  end
end

