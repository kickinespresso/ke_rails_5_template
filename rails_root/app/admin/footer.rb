module ActiveAdmin
  module Views
    class Footer < Component

      def build
        super :id => "footer"
        super :style => "text-align: left;"

        div do
          link_to "KickinEspresso #{Date.today.year}", 'http://www.kickinespresso.com'
        end
      end

    end
  end
end