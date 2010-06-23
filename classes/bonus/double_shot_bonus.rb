class DoubleShotBonus < Bonus

  def initialize
    super
    @img = Flonkerton::Images[:double_shot_bonus]
    @perk = DoubleShotPerk
  end

  private

  def speed
    3
  end

end

