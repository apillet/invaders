class Player
  attr_accessor :width, :height, :x, :y, :score
  def initialize
    @lives = 5
    @score = 0
    @width = 25
    @height = 30
    @x = @y = 0
    @health = 2
    @perk = DefaultPerk.new
    @old_perk = @perk
    @last_shot = Gosu::milliseconds
    @image = Flonkerton::Images[:ship]
  end

  def place(x)
    if x.is_a? Fixnum then
      @x = x
    elsif x.is_a? Symbol then
      case x
      when :left then
        @x = 0
      when :center then
        @x = (Flonkerton::CONFIG[:width]/2) - (@width / 2)
      when :right then
        @x = Flonkerton::CONFIG[:width] - @width
      end
    end
    @y = Flonkerton::CONFIG[:height] - Flonkerton::CONFIG[:PLAYER_Y_POSITION_FROM_BOTTOM].to_i
  end

  def move(direction)
    case direction
    when :left then
      unless @x <= Flonkerton::CONFIG[:PLAYER_MOVING_DISTANCE].to_i then
        @x -= Flonkerton::CONFIG[:PLAYER_MOVING_DISTANCE].to_i
      end
    when :right then
      unless Flonkerton::CONFIG[:width] - @x <= Flonkerton::CONFIG[:PLAYER_MOVING_DISTANCE].to_i then
        @x += Flonkerton::CONFIG[:PLAYER_MOVING_DISTANCE].to_i
      end
    end
  end

  def shoot
    _shoot(@perk.shot_type) unless (Gosu::milliseconds - @last_shot) < @perk.shooting_interval
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

  def warn

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

