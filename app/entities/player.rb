module Entities
  class Player < Hoard::Entity
    collidable

    attr_reader :notifier, :walk_speed, :user

    def initialize(user:)
      super(cx: 12, cy: 9, parent: user)

      @tile_x = 0
      @tile_y = 16 * 12

      @user = user

      @tile_w = 16
      @tile_h = 16
      @w = 16
      @h = 16

      @scale_x = 1
      @scale_y = 1

      @walk_speed = 0

      @v_base.set_fricts(0.84, 0.94)
      @spawned = false

      Game.s.camera.track_entity(self, true)
      Game.s.camera.clamp_to_level_bounds = true

      add_script Hoard::Scripts::LdtkEntityScript.new
      add_script Hoard::Scripts::SaveDataScript.new

      add_script Scripts::PlayerAnimationsScript.new
      add_script Hoard::Scripts::GravityScript.new(0.025)
      add_script Hoard::Scripts::HorizontalMovementScript.new
      add_script Hoard::Scripts::HealthScript.new(health: 3)
      add_script Hoard::Scripts::JumpScript.new(jumps: 2, power: 0.45)

      send_to_scripts(:play_animation, :idle, true)
    end

    def spawned?
      @spawned
    end

    def respawn!
      send_to_scripts(:reset!)
      @spawned = false
      Game.s.start_game
      @destroyed = false
      @visible = true
      v_base.clear
      v_bump.clear

      Game.s.fx.anim({
        path: "sprites/effects.png",
        x: center_x,
        y: center_y.from_top + 4,
        tile_w: 64,
        tile_h: 64,
        tile_x: 0,
        tile_y: 4 * 64,
        frames: 11,
        w: 32,
        h: 32,
      })
    end

    def set_pos_case(cx, cy)
      super(cx, cy)
      @spawned = true
    end

    def pre_update
      super

      @walk_speed = 0

      if Game.s.inputs.keyboard.key_held.left
        @walk_speed = -0.6
        self.dir = -1
        p "On ground? #{on_ground?}, #{v_base.dy}, #{yr}, #{has_collision(cx, cy + 1)}"
        send_to_scripts(:play_animation, :walk) if on_ground?
      elsif Game.s.inputs.keyboard.key_held.right
        @walk_speed = 0.6
        self.dir = 1
        p "On ground? #{on_ground?}, #{v_base.dy}, #{yr}, #{has_collision(cx, cy + 1)}"

        send_to_scripts(:play_animation, :walk) if on_ground?
      else
        send_to_scripts(:play_animation, :idle) if on_ground? && !cd.has("landing")
      end

      if Game.s.inputs.keyboard.key_held.up
        @walk_speed = 0
        if Game.s.current_level.layer("Collisions").int(cx, cy) == 2 # ladder
          v_base.dy = -0.2
        end
      end
    end

    ##
    # Move an entity to a new level, given their current world coords
    def move_to_neighbour(wx, wy)
      level = Game.s.current_level
      neighbour = level.find_neighbour(wx, wy)

      return unless neighbour

      wcx = (neighbour.world_x / Hoard::Const::GRID)
      wcy = (neighbour.world_y / Hoard::Const::GRID)

      set_pos_case(wx - wcx, wy - wcy)
      Game.s.start_level(neighbour)
    end

    def on_pre_step_x
      super

      if xr > 0.8
        self.xr = 0.8 if has_collision(cx + 1, cy)
        move_to_neighbour(wcx + 1, wcy) if has_exit?(cx + 1, cy)
      end

      if xr < 0.2
        self.xr = 0.2 if has_collision(cx - 1, cy)
        move_to_neighbour(wcx - 1, wcy) if has_exit?(cx - 1, cy)
      end
    end

    def on_pre_step_y
      super

      if yr >= 1
        move_to_neighbour(wcx, wcy + 1) if has_exit?(cx, cy + 1)
      end

      if yr < 0.2
        move_to_neighbour(wcx, wcy - 1) if has_exit?(cx, cy - 1)
      end

      if yr < 0.2
        if has_collision(cx, cy - 1)
          self.yr = 0.2
        end
      end
    end

    def post_update
      super
      #@notifier.post_update
    end
  end
end
