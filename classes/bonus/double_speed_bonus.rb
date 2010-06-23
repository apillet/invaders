class DoubleSpeedBonus < Bonus

  def initialize(x,y)
    super
    @img = Flonkerton::Images[:double_speed_bonus]
    @perk = DoubleSpeedPerk
    @duration = 3
  end

  private

  def speed
    2
  end

end

