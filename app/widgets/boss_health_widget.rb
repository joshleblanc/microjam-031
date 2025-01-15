module Widgets
  class BossHealthWidget < Hoard::Widget
    def initialize
      super
      show!
    end

    def render
      health_script = entity.health_script
      return unless health_script
      health_percent = health_script.life.v.to_f / health_script.life.max

      p "Rendering"
      window(
        key: "health",
        x: 100,
        y: 20,
        w: 1080,
        h: 20,
        padding: 0,
        margin: 0,
        background: { r: 60, g: 60, b: 60 },
        border: { r: 255, g: 255, b: 255 },
      ) do
        window(
          w: 1080 * health_percent,
          h: "100%",
          padding: 0,
          margin: 0,
          background: { r: 200, g: 50, b: 50 },
        )
      end
    end
  end
end
