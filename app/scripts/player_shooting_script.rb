module Scripts
  class PlayerShootingScript < Hoard::Script
    def initialize
      @shoot_cooldown = 20
      @current_cooldown = 0
    end

    def update
      @current_cooldown -= 1 if @current_cooldown > 0

      if Game.s.inputs.keyboard.key_held.z && @current_cooldown <= 0
        shoot
        @current_cooldown = @shoot_cooldown
      end
    end

    private

    def shoot
      offset_x = entity.dir > 0 ? 1 : 0

      offset_y = -0.25

      Entities::PlayerProjectile.new(
        cx: entity.cx,
        cy: entity.cy,
        w: 16,
        h: 16,
        parent: entity,
      )
    end
  end
end
