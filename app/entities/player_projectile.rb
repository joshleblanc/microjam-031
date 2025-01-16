module Entities
  class PlayerProjectile < Hoard::Entity
    script Hoard::Scripts::AnimationScript.new(
      :player_projectile,
      files: [
        "sprites/particles/circle_01.png",
        "sprites/particles/circle_02.png",
        "sprites/particles/circle_03.png",
        "sprites/particles/circle_04.png",
        "sprites/particles/circle_05.png",
      ],
      tile_w: 512,
      tile_h: 512,
    )
    script Scripts::PlayerProjectileScript.new

    def initialize(...)
      super
      send_to_scripts(:play_animation, :player_projectile, true)
    end
  end
end
