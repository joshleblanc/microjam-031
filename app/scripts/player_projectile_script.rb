module Scripts
  class PlayerProjectileScript < Hoard::Script
    def initialize
      @speed = 2
    end

    def init
      @dir = entity.parent.dir
    end

    def update
      # Move in player's facing direction
      if @dir == 0
        entity.v_base.dy = -@speed * entity.dt
      else
        entity.v_base.dx = @speed * @dir * entity.dt
      end

      # Remove if off screen
      if entity.x < -50 || entity.x > 1330 || entity.y < -50 || entity.y > 770
        entity.destroy!
      end
    end

    def post_update
      if Geometry.intersect_rect?(entity, Game.s.boss)
        Game.s.boss.apply_damage(10, entity.parent)
        entity.destroy!
      end
      args.outputs[:scene].solids << {
        x: entity.rx, y: entity.ry, w: entity.w, h: entity.h, r: 0, g: 255, b: 0,
      }
    end
  end
end
