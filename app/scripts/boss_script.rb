module Scripts
  class BossScript < Hoard::Script
    PHASES = 3

    def init
      @positions = {}
      @current_phase = 2
      # run this next frame
      Hoard::Scheduler.schedule do |s, blk|
        s.wait { activate_next_phase! }
      end
    end

    def register_boss_position(position)
      p "Registering boss position, #{position}, #{position.find_script_property(:phase)}"
      @positions[position.find_script_property(:phase)] = position
    end

    def activate_next_phase!
      @current_phase += 1
      if @current_phase > PHASES
        @current_phase = 1
      end
      activate_phase(@current_phase)
    end

    def activate_phase(phase)
      p "activating #{phase}, move to: #{@positions[phase]}"
      entity.move_to @positions[phase], 2000, Hoard::Tween::Type::ELASTIC_END
      entity.send("boss_attack_#{phase}_script".to_sym).activate!
    end
  end
end
