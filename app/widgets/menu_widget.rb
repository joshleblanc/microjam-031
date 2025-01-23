module Widgets
  class MenuWidget < Hoard::Widget
    def render 
      window(key: :menu, w: 1280, h: 720, background: { r: 255, g: 200, b: 200 }) do 
        row(border: { r: 0, g: 0, b: 255 }) do 
          col(span: 12) do 
            button(w: "100%", h: 40, border: { r: 0, g: 0, b: 0 }) do 
              text { "Test" }
            end
          end
        end
      end
    end
  end
end
