module Scripts
  class BulletProjectileScript < Hoard::Script
    def initialize
      @speed = 1
      @direction = 0
    end

    def on_collision(player)
      return unless player.is_a?(Entities::Player)

      player.apply_damage(1, entity)
    end

    def update
      # Move in the direction set at spawn
      entity.v_base.dx = Math.cos(@direction) * @speed * entity.dt
      entity.v_base.dy = Math.sin(@direction) * @speed * entity.dt

      # Remove if off screen
      if entity.x < -50 || entity.x > 1330 || entity.y < -50 || entity.y > 770
        entity.destroy!
      end
    end

    def set_direction(angle)
      @direction = angle
    end

    def post_update
      args.outputs[:scene].solids << {
        x: entity.rx, y: entity.ry, w: 3, h: 3, r: 255, g: 0, b: 0,
      }
    end
  end
end
