module Scripts
  class BossAttack1Script < Hoard::Script
    HAZARD_WARNING_TIME = 3 * 60  # 3 seconds in frames
    HAZARD_ACTIVE_TIME = 2 * 60   # 2 seconds in frames
    HAZARD_FADE_TIME = 30         # 0.5 seconds in frames

    def init
      @platform_spawns ||= []
      @phase_started = false
    end

    def platforms
      entity.children.select { |child| child.is_a?(Entities::Platform) }
    end

    def hazards
      entity.children.select { |child| child.is_a?(Entities::FireHazard) }
    end

    def activate!
      return if @phase_started

      @wave_timer = HAZARD_WARNING_TIME
      @current_wave = -1

      @platform_spawns.each do |platform_spawn|
        Entities::Platform.new(
          cx: platform_spawn.cx,
          cy: platform_spawn.cy,
          parent: self.entity,
          tile_w: 48,
          w: 48,
          anchor_x: platform_spawn.anchor_x,
          anchor_y: platform_spawn.anchor_y,
        )
        Entities::FireHazard.new(
          cx: platform_spawn.cx,
          cy: platform_spawn.cy - 1,
          parent: self.entity,
          tile_w: 48,
          w: 48,
          h: 48,
          anchor_x: platform_spawn.anchor_x,
          anchor_y: 1,
        )
      end

      @phase_started = true

      start_next_wave!
    end

    def register_platform_spawn(platform_spawn)
      @platform_spawns ||= []
      @platform_spawns << platform_spawn
    end

    def finish_phase!
      @phase_started = false
      entity.destroy_all_children!

      p Hoard::Process::ROOTS

      entity.send_to_scripts(:activate_next_phase!)
    end

    def start_next_wave!
      @wave_timer = HAZARD_WARNING_TIME
      @state = :warning
      @current_wave += 1

      return finish_phase! if @current_wave >= wave_patterns.length

      show_hazards!
    end

    def update
      return unless @phase_started

      @wave_timer -= 1

      case @state
      when :warning
        if @wave_timer <= 0
          activate_hazards!
          @wave_timer = HAZARD_ACTIVE_TIME
          @state = :active
        end
      when :active
        if @wave_timer <= 0
          @wave_timer = HAZARD_FADE_TIME
          @state = :fading
        end
      when :fading
        if @wave_timer <= 0
          clear_hazards!
          start_next_wave!
        end
      end
    end

    def show_hazards!
      wave_patterns[@current_wave].each do |platform|
        hazards[platform]&.send_to_scripts(:preactivate!)
      end
    end

    def activate_hazards!
      wave_patterns[@current_wave].each do |inx|
        hazards[inx]&.send_to_scripts(:activate!)
      end
    end

    def clear_hazards!
      wave_patterns[@current_wave].each do |inx|
        hazards[inx]&.send_to_scripts(:deactivate!)
      end
    end

    def wave_patterns
      [
        [0],
        [1, 2],
        [3, 2],
        [0, 2, 1],
        [1, 3],
      ]
    end
  end
end
