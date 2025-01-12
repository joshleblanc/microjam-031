module Scripts
  class BossAttack2Script < Hoard::Script
    HAZARD_WARNING_TIME = 3 * 60  # 3 seconds in frames
    HAZARD_ACTIVE_TIME = 2 * 60   # 2 seconds in frames
    HAZARD_FADE_TIME = 30         # 0.5 seconds in frames
    PILLAR_WIDTH = 48             # Width of each damage pillar

    def init
      @pillar_spawns ||= []
      @phase_started = false
    end

    def hazards
      entity.children.select { |child| child.is_a?(Entities::FireHazard) }
    end

    def register_pillar_spawn(pillar_spawn)
      @pillar_spawns ||= []
      @pillar_spawns << pillar_spawn
    end

    def activate!
      return if @phase_started

      @wave_timer = HAZARD_WARNING_TIME
      @current_wave = -1

      @pillar_spawns.each do |pillar_spawn|
        Entities::FireHazard.new(
          cx: pillar_spawn.cx,
          cy: pillar_spawn.cy,
          parent: self.entity,
          tile_w: PILLAR_WIDTH,
          w: PILLAR_WIDTH,
          h: 800,
        )
      end

      @phase_started = true
      start_next_wave!
    end

    def finish_phase!
      @phase_started = false
      entity.destroy_all_children!
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
      wave_patterns[@current_wave].each do |pillar|
        hazards[pillar]&.send_to_scripts(:preactivate!)
      end
    end

    def activate_hazards!
      p "Activating wave #{@current_wave}"
      wave_patterns[@current_wave].each do |inx|
        hazards[inx]&.send_to_scripts(:activate!)
      end
    end

    def clear_hazards!
      hazards.each do |hazard|
        hazard.send_to_scripts(:deactivate!)
      end
    end

    private

    def wave_patterns
      [
        [0, 2, 4],
        [1, 3],
        [0, 1, 2, 3, 4],
      ]
    end
  end
end
