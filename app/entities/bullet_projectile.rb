module Entities
  class BulletProjectile < Hoard::Entity
    script Scripts::BulletProjectileScript.new
    script Hoard::Scripts::AnimationScript.new(
      :bullet_projectile,
      frames: 8,
      path: "sprites/bullets/part5c.png",
      tile_w: 24,
      tile_h: 24,
      speed: 5,
      x: 16 * 24,
      y: 12 * 24,
      anchor_x: 0.5,
      anchor_y: 0.5,
    )

    def initialize(...)
      super
      send_to_scripts(:play_animation, :bullet_projectile, true)
    end
  end
end
