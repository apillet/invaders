class TripleShotBonus < Bonus

  def initialize(window,x,y)
    super
    @img = Flonkerton::Images[:triple_shot_bonus]
    @perk = TripleShotPerk
    @duration = 2
  end

  private

  def speed
    4
  end

end

