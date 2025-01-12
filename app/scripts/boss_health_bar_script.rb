module Scripts
  class BossHealthBarScript < Hoard::Script
    def post_update
      health_script = entity.health_script
      return unless health_script

      # Health bar background
      args.outputs.solids << {
        x: 100,
        y: 680,
        w: 1080,
        h: 20,
        r: 60,
        g: 60,
        b: 60,
      }

      # Health bar fill
      health_percent = health_script.life.v.to_f / health_script.life.max
      args.outputs.solids << {
        x: 100,
        y: 680,
        w: 1080 * health_percent,
        h: 20,
        r: 200,
        g: 50,
        b: 50,
      }

      # Border
      args.outputs.borders << {
        x: 100,
        y: 680,
        w: 1080,
        h: 20,
        r: 255,
        g: 255,
        b: 255,
      }
    end
  end
end
