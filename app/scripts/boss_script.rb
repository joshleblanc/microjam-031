module Scripts
  class BossScript < Hoard::Script
    PHASES = 3

    def init
      p "hullo?"
      @current_phase = 2
      # run this next frame
      Hoard::Scheduler.schedule do |s, blk|
        s.wait { activate_next_phase! }
      end
    end

    def activate_next_phase!
      @current_phase += 1
      if @current_phase > PHASES
        @current_phase = 1
      end
      p "activating next phase"
      activate_phase(@current_phase)
    end

    def activate_phase(phase)
      p "activating #{phase}"
      entity.send("boss_attack_#{phase}_script".to_sym).activate!
    end
  end
end
