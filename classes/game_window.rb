class GameWindow < Flonkerton::Screen

  attr_accessor :player

  def setup
    @player = Player.new
    initialize_level
    initialize_events
  end

  def draw
    @player.draw
    Bullet.draw_all
    Enemy.draw_all
    Bonus.draw_all
  end

  def update
    close if @player.dead?

    @player.move_left  if button_down? Gosu::KbLeft
    @player.move_right if button_down? Gosu::KbRight
    @player.shoot      if button_down? Gosu::KbSpace

    ScheduledEvent.call_all
    RandomEvent.call_all
    Bullet.move_all
    Bonus.move_all
    check_collisions
  end

  private

  def check_collisions
    EnemyBullet.all.each do |enemy_bullet|
      if enemy_bullet.collides?(@player) then
        @player.hurt(enemy_bullet.power)
        enemy_bullet.destroy
      end
    end
    PlayerBullet.all.each do |player_bullet|
      Enemy.all.each do |enemy|
        if player_bullet.collides?(enemy) then
          enemy.hurt(player_bullet.power)
          player_bullet.destroy
        end
      end
    end
    Bonus.all.each do |bonus|
      if bonus.collides?(@player) then
        @player.add_bonus(bonus)
        bonus.destroy
      end
    end
    Enemy.all.each do |enemy|
      @player.die if enemy.collides?(@player)
    end
  end

  def initialize_events
    RandomEvent.new(5,0.2) do
      DoubleShotBonus.new
    end

    RandomEvent.new(5,0.1) do
      TripleShotBonus.new
    end

    RandomEvent.new(5,0.3) do
      DoubleSpeedBonus.new
    end

    RandomEvent.new(10,0.8) do
      Enemy.all.each do |enemy|
        enemy.renew_shooting_pattern
      end
    end

    ScheduledEvent.new(1.5) do
      Enemy.all.each do |enemy|
        enemy.approach(5)
      end
    end

    ScheduledEvent.new(0.7) do
      Enemy.move_all
    end
  end

  def initialize_level num = 0
    levels = Flonkerton::CONFIG[:levels]
    level = levels[num][:enemies]
    enemy_type = Flonkerton::CONFIG[:enemy_type]
    padding_x = Flonkerton::CONFIG[:padding_x]
    padding_y = Flonkerton::CONFIG[:padding_y]
    enemy_width = Flonkerton::CONFIG[:enemy_width]
    enemy_height = Flonkerton::CONFIG[:enemy_height]

    level.each_with_index do |line, y|
      line.split('').each_with_index do |char, x|
        if klass = enemy_type[char.to_sym]
          position = [padding_x + x * enemy_width, padding_y + y * enemy_height]
          Module.class_eval(klass).new(position)
        end
      end
    end
  end
end
