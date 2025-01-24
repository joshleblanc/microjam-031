module Widgets
  class MenuWidget < Hoard::Widget

    class Button < Hoard::Ui::Element     
      default_block do
        button(
          w: "100%", h: "100%", 
          align: :center, justify: :center, 
          border: { r: 0, g: 0, b: 0 },
          background: { r: 255, g: 255, b: 255, a: 100 },
        ) do 
          render_content
        end 
      end
    end

    def render
      window(key: :menu, w: 1280, h: 720, background: { r: 0, g: 0, b: 0 }) do 
        window(
          key: :inner_menu, 
          w: 720, h: 480, align: :center, justify: :center, 
          background: { r: 255, g: 255, b: 255, a: 100 },
          border: { r: 255, g: 255, b: 255, a: 150 }
        ) do 
          window({
            w: 400, h: 200, align: :center, justify: :center,
            background: { r: 255, g: 255, b: 255, a: 100 },
            border: { r: 255, g: 255, b: 255, a: 150 }
          }) do 
            row do 
              col(span: 12) do
                menu_widget_button(w: "100%", h: 40) do 
                  text { "Play!"}
                end
              end
            end
            # row do 
            #   col(span: 12) do
            #      embed(Button.new do 
            #         text { "Quit!" }
            #      end)
            #   end
            # end
          end
        end
      end
    end
  end
end
