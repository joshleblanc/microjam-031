module Scripts
  class BulletProjectileScript < Hoard::Script
    def initialize
      @speed = 0.05
      @direction = 0
    end

    def on_collision(player)
      return unless player.is_a?(Entities::Player)

      player.apply_damage(1, entity)
    end

    def update
      # Move in the direction set at spawn
      entity.v_base.dx = Math.cos(@direction) * @speed
      entity.v_base.dy = Math.sin(@direction) * @speed

      # Remove if off screen
      if entity.x < -50 || entity.x > 1330 || entity.y < -50 || entity.y > 770
        entity.destroy!
      end
    end

    def set_direction(angle)
      @direction = angle
    end
  end
end
