module Scripts
  class PlayerProjectileScript < Hoard::Script
    def initialize
      @speed = 0.25
    end

    def init
      @dir = entity.parent.dir
    end

    def update
      # Move in player's facing direction
      entity.v_base.dx = @speed * @dir

      # Remove if off screen
      if entity.x < -50 || entity.x > 1330 || entity.y < -50 || entity.y > 770
        entity.destroy!
      end
    end

    def post_update
      intersecting = Geometry.intersect_rect?(Game.s.boss, entity, 0)
      boss_rect = { x: Game.s.boss.x, y: Game.s.boss.y, w: Game.s.boss.w, h: Game.s.boss.h }
      bullet_rect = { x: entity.x, y: entity.y, w: entity.w, h: entity.h }
      p "Intersecting #{intersecting}, #{boss_rect}, #{bullet_rect}"
      if intersecting
        Game.s.boss.apply_damage(10, entity.parent)
        entity.destroy!
      end
      args.outputs[:scene].solids << {
        x: entity.rx, y: entity.ry, w: entity.w, h: entity.h, r: 0, g: 255, b: 0,
      }
    end
  end
end
