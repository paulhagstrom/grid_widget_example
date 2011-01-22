module BooksHelper
  module ::GridWidget::AppSupport
    module ControllerMethods
    end

    module HelperMethods

      def helper_to_render_a_little_checkmark(id = 'default_checkmark_id')
        raw "<span id='#{id}' class='ui-icon ui-icon-check'></span>"
      end

    end
  end
end
