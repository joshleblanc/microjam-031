module Scripts
  class PlayerShootingScript < Hoard::Script
    def initialize
      @shoot_cooldown = 0.5  # Time between shots in seconds
      @current_cooldown = 0
    end

    def update
      @current_cooldown -= entity.dt if @current_cooldown > 0

      if Game.s.inputs.keyboard.key_held.z && @current_cooldown <= 0
        shoot
        @current_cooldown = @shoot_cooldown
      end
    end

    private

    def shoot
      # Spawn projectile slightly in front of player based on direction
      offset_x = entity.dir > 0 ? 1 : 0
      offset_x = 0.4 if entity.dir == 0

      offset_y = -0.25
      offset_y = -0.5 if entity.dir == 0

      Entities::PlayerProjectile.new(
        cx: entity.cx + offset_x,
        cy: entity.cy + offset_y,
        w: 3,
        h: 3,
        parent: entity,
      )
    end
  end
end
