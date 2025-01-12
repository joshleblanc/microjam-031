module Scripts
  class MenuScript < Hoard::Script
    def initialize
      @state = :main_menu  # :main_menu, :playing, :game_over, :victory
      @button_w = 200
      @button_h = 50
    end

    def update
      handle_input
    end

    def post_update
      case @state
      when :main_menu
        render_main_menu
      when :game_over
        render_game_over
      when :victory
        render_victory
      end
    end

    private

    def handle_input
      return if @state == :playing

      mouse = args.inputs.mouse
      button_x = 640 - @button_w / 2
      button_y = 360 - @button_h / 2

      if mouse.click &&
         mouse.x >= button_x &&
         mouse.x <= button_x + @button_w &&
         mouse.y >= button_y &&
         mouse.y <= button_y + @button_h

        case @state
        when :main_menu
          start_game
        when :game_over, :victory
          return_to_menu
        end
      end
    end

    def render_button(text)
      button_x = 640 - @button_w / 2
      button_y = 360 - @button_h / 2

      # Button background
      args.outputs.solids << {
        x: button_x,
        y: button_y,
        w: @button_w,
        h: @button_h,
        r: 60,
        g: 60,
        b: 60,
      }

      # Button border
      args.outputs.borders << {
        x: button_x,
        y: button_y,
        w: @button_w,
        h: @button_h,
        r: 255,
        g: 255,
        b: 255,
      }

      # Button text
      args.outputs.labels << {
        x: 640,
        y: 360 + 8,
        text: text,
        alignment_enum: 1,
        r: 255,
        g: 255,
        b: 255,
      }
    end

    def render_title(text)
      args.outputs.labels << {
        x: 640,
        y: 500,
        text: text,
        size_enum: 4,
        alignment_enum: 1,
        r: 255,
        g: 255,
        b: 255,
      }
    end

    def render_main_menu
      render_title("BOSS BATTLE")
      render_button("START")
    end

    def render_game_over
      render_title("GAME OVER")
      render_button("MENU")
    end

    def render_victory
      render_title("VICTORY!")
      render_button("MENU")
    end

    def start_game
      @state = :playing
      Game.s.start_game
    end

    def return_to_menu
      @state = :main_menu
      Game.s.reset!
    end

    def game_over!
      @state = :game_over
    end

    def victory!
      @state = :victory
    end
  end
end
