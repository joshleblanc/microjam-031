module Scripts
  class BossAttack3Script < Hoard::Script
    def initialize
      @active = false
      @bullet_spawn_timer = 0
      @bullet_spawn_interval = 120
      @rotation = 0
      @bullets_per_wave = 1
      @target_x = 1100  # Right side of the screen
    end

    def update
      return unless @active

      # Spawn bullets in a circular pattern
      @bullet_spawn_timer -= 1
      if @bullet_spawn_timer <= 0
        @bullet_spawn_timer = @bullet_spawn_interval
        spawn_bullet_wave
      end

      # Rotate the pattern
      @rotation += 5
    end

    def spawn_bullet_wave
      @bullets_per_wave.times do |i|
        angle = Geometry.angle(entity, Game.s.player).to_radians
        bullet = Entities::BulletProjectile.new(
          cx: @entity.cx,
          cy: @entity.cy,
          w: 16,
          h: 16,
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
