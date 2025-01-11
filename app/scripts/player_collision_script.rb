module Scripts
  class PlayerCollisionScript < Hoard::Script
    def on_collision(from)
      return unless from.is_a? Entities::Boss

      entity.apply_damage(1, from)
    end
  end
end
