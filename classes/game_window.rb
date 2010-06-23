class GameWindow < Flonkerton::Screen
  attr_accessor :player
  def setup
    @player = Player.new(@game)
    @player.place :center
    @background = Flonkerton::Images[:menu]
    @grid = EnemyGrid.new(@game,width, height, 2, 8)
    initialize_events
  end

  def draw
    @background.draw
    @player.draw
    Bullet.draw_all
    Enemy.draw_all
    Bonus.draw_all
  end

  def update
    if button_down? Gosu::Button::KbLeft then
      @player.move :left
    elsif button_down? Gosu::Button::KbRight then
      @player.move :right
    end
    if button_down? Gosu::Button::KbSpace then
      @player.shoot
    end

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
      DoubleShotBonus.new(@game,rand * width, -10)
    end

    RandomEvent.new(5,0.1) do
      TripleShotBonus.new(@game, rand * width, -10)
    end

    RandomEvent.new(5,0.3) do
      DoubleSpeedBonus.new(@game, rand * width, -10)
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
end

