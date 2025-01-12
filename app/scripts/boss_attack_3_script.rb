module Scripts
  class BossAttack3Script < Hoard::Script
    def initialize
      @active = false
      @bullet_spawn_timer = 0
      @bullet_spawn_interval = 0.25
      @rotation = 0
      @bullets_per_wave = 1
      @target_x = 1100  # Right side of the screen
    end

    def update
      return unless @active

      # Move to right side if not there yet
      if (@entity.x - @target_x).abs > 5
        direction = @target_x > @entity.x ? 1 : -1
        @entity.x += direction * 300 * entity.dt
      end

      # Spawn bullets in a circular pattern
      @bullet_spawn_timer -= entity.dt
      if @bullet_spawn_timer <= 0
        @bullet_spawn_timer = @bullet_spawn_interval
        spawn_bullet_wave
      end

      # Rotate the pattern
      @rotation += 5
    end

    def spawn_bullet_wave
      @bullets_per_wave.times do |i|
        angle = (@rotation + (i * 360.0 / @bullets_per_wave)) * Math::PI / 180.0
        bullet = Entities::BulletProjectile.new(
          cx: @entity.cx + 0.5,
          cy: @entity.cy - 0.5,
          w: 3,
          h: 3,
        )
        bullet.send_to_scripts(:set_direction, angle)
      end
    end

    def activate!
      @active = true
    end

    def deactivate!
      @active = false
    end
  end
end
