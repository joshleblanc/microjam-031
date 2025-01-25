module Widgets
  class MenuWidget < Hoard::Widget

    class Button < Hoard::Ui::CustomElement
      default_block do
        button(
          w: "100%", h: 40,
          align: :center, justify: :center, 
          border: { r: 0, g: 0, b: 0 },
          background: { r: 255, g: 255, b: 255, a: 100 },
          on_click: -> { props.on_click.call}
        ) do 
          text { props.label }
        end 
      end
    end

    class InnerContainer < Hoard::Ui::CustomElement
      default_block do
        window(
          w: 720, h: 480, align: :center, justify: :center, 
          background: { r: 255, g: 255, b: 255, a: 100 },
          border: { r: 255, g: 255, b: 255, a: 150 }
        ) do 
          render_content
        end
      end
    end

    class Buttons < Hoard::Ui::CustomElement
      default_block do 
        window({
          padding: 1,
          w: 400, h: 200, align: :bottom, justify: :center,
          background: { r: 255, g: 255, b: 255, a: 100 },
        }) do 
          render_content
        end
      end
    end

    class Row < Hoard::Ui::CustomElement
      default_block do 
        row(padding: 10) do 
          render_content
        end
      end
    end

    def start_game 
      hide!
      Game.s.start_level(Game.s.root.levels.first)
    end

    def render
      window(w: 1280, h: 720, background: { r: 0, g: 0, b: 0 }, justify: :center, align: :center) do         
        menu_widget_inner_container do 
          menu_widget_buttons do 
            row do
              col(span: 12) do 
                text { "Microjam 031"}
              end
            end
            row do 
              col(span: 12, h: 40) {}
            end
            menu_widget_row do 
              col(span: 12) do
                menu_widget_button(label: "Play!", on_click: -> { widget.start_game })
              end
            end
            menu_widget_row do 
              col(span: 12) do
                menu_widget_button(label: "Quit!", on_click: -> { args.gtk.request_quit })
              end
            end
          end
        end
      end
    end
  end
end
