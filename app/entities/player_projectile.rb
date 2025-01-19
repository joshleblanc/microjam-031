module Entities
  class PlayerProjectile < Hoard::Entity
    script Hoard::Scripts::AnimationScript.new(
      :player_projectile,
      frames: 10,
      path: "sprites/smoke-effects/smoke3.png",
      tile_w: 64,
      tile_h: 64,
      speed: 5,
      x: 1 * 64,
      y: 8 * 64,
      reverse: false,
    )
    script Scripts::PlayerProjectileScript.new

    def initialize(...)
      super
      send_to_scripts(:play_animation, :player_projectile, false) do
        destroy!
      end
    end
  end
end
