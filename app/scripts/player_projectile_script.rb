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
      if intersecting
        Game.s.boss.apply_damage(10, entity.parent)
        entity.destroy!
      end
    end
  end
end
