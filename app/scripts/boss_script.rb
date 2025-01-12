module Scripts
  class BossScript < Hoard::Script
    def init
      # run this next frame
      Hoard::Scheduler.schedule do |s, blk|
        s.wait { entity.boss_attack_1_script.activate }
      end
    end
  end
end
