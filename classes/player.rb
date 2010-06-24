class Player

  attr_accessor :width, :height, :x, :y, :score

  def initialize
    @lives = 5
    @score = 0
    @image = Flonkerton::Images[:ship]
    @width = @image.width
    @height = @image.height
    @x = Flonkerton::CONFIG[:width] / 2 - @width / 2
    @y = Flonkerton::CONFIG[:height] - Flonkerton::CONFIG[:PLAYER_Y_POSITION_FROM_BOTTOM].to_i
    @health = 2
    @perk = DefaultPerk.new
    @old_perk = @perk
    @last_shot = Gosu::milliseconds
  end

  def move_left
    unless @x <= moving_distance
      @x -= moving_distance
    end
  end

  def move_right
    unless Flonkerton::CONFIG[:width] - @x <= moving_distance + @image.width
      @x += moving_distance
    end
  end

  def moving_distance
    @moving_distance ||= Flonkerton::CONFIG[:PLAYER_MOVING_DISTANCE].to_i
  end

  def shoot
    _shoot(@perk.shot_type) unless reloading?
  end

  def draw
    @image.draw :x => @x,
                :y => @y,
                :z => 1
  end

  def die
    puts "DIED"
    @health = 0
  end

  def hurt(damage)
    @health -= damage
    puts "HURT"
  end

  def dead?
    @health <= 0
  end

  def reloading?
    Gosu::milliseconds - @last_shot < @perk.shooting_interval
  end

  def add_bonus(bonus)
    @old_perk = @perk
    @perk = bonus.perk.new
    _perk_wear_off_after(bonus.duration)
  end

  def remove_bonus
    @perk = @old_perk
  end

  def reset_all_perks
    @perk = DefaultPerk.new
  end

  def score(points)
    @score += points
    puts "Scored #{points}!"
  end

private

  def _shoot(type)
    case type
    when :single then
      NormalBullet.new(@x + (@width / 2), @y)
    when :double then
      NormalBullet.new(@x + (@width / 3), @y)
      NormalBullet.new((@x + @width) - (@width / 3), @y)
    when :triple then
      NormalBullet.new(@x + (@width / 4), @y, :left)
      NormalBullet.new(@x + (@width / 2), @y)
      NormalBullet.new((@x + @width) - (@width / 4), @y, :right)
    end
    @last_shot = Gosu::milliseconds
  end

  def _perk_wear_off_after(seconds)
    e = ScheduledEvent.new(seconds) do
      reset_all_perks
      e.destroy
    end
  end
end
