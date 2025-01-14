module Debug
  class << self
    def render_grid(outputs)
      scene_width = 1280  # Standard game width
      scene_height = 720  # Standard game height
      grid_size = Hoard::Const::GRID     # Size of each grid cell

      # Vertical lines
      x = 0
      while x <= scene_width
        outputs << {
          x: x,
          y: 0,
          x2: x,
          y2: scene_height,
          r: 128,
          g: 128,
          b: 128,
          a: 80,
          primitive_marker: :line,
        }
        x += grid_size
      end

      # Horizontal lines
      y = 0
      while y <= scene_height
        outputs << {
          x: 0,
          y: y,
          x2: scene_width,
          y2: y,
          r: 128,
          g: 128,
          b: 128,
          a: 80,
          primitive_marker: :line,
        }
        y += grid_size
      end
    end
  end
end
