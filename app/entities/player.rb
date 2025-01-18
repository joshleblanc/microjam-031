module Entities
  class Player < Hoard::Entity
    collidable
    attr_reader :user

    def initialize(user:)
      super(cx: 12, cy: 9, parent: user)

      @user = user

      @v_base.set_fricts(0.84, 0.94)

      Game.s.camera.track_entity(self, true)
      Game.s.camera.clamp_to_level_bounds = true

      add_script Hoard::Scripts::LdtkEntityScript.new
      add_script Hoard::Scripts::SaveDataScript.new
      add_script Hoard::Scripts::DisableControlsScript.new

      add_script Scripts::PlayerAnimationsScript.new
      add_script Hoard::Scripts::GravityScript.new(0.02)
      add_script Hoard::Scripts::HealthScript.new(health: 3)
      add_script Hoard::Scripts::JumpScript.new(jumps: 2, power: 0.45)
      add_script Scripts::PlayerCollisionScript.new
      add_script Scripts::PlayerShootingScript.new
      add_script Hoard::Scripts::HealthScript.new(health: 3)
      add_script Hoard::Scripts::PlatformerControlsScript.new
      add_script Hoard::Scripts::MoveToNeighbourScript.new
      send_to_scripts(:play_animation, :idle, true)
    end
  end
end
