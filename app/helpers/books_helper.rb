module BooksHelper
  module ::AppSupport
    module Controller
    end

    module Helper

      def helper_to_render_a_little_checkmark(id = 'default_checkmark_id')
        raw "<span id='#{id}' class='ui-icon ui-icon-check'></span>"
      end

    end
  end
end
