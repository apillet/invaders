 class NormalEnemy < Enemy

  def initialize(window,x_y)
    super
    @width = 26
    @height = 23
    @img = Flonkerton::Images[:normal_enemy]
    @pattern = nil
    @facing = :right
  end

  private

  def movement
    5
  end
end

