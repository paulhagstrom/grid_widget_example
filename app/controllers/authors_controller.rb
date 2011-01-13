class AuthorsController < BaseController

  has_widgets do |root|
    book_widget = grid_edit_widget('book') do |cc|
      cc.grid_options = {
        :title => 'Books',
        # :rows => 20,
        :height => 150,
        # :pager => {:rows => 20, :rows_options => ['20','50','100']},
        :del_button => true,
        :add_button => true,
      }
      cc.add_column('title', :width => 150, :sortable => true, :open_panel => true, :custom => :custom_title)
      cc.add_column('price', :label => 'Price (USD)', :width => 75, :sortable => true, :custom => :custom_price)
      cc.add_column('read', :width => 50, :sortable => true, :toggle => true, :custom => :custom_check)
      def cc.custom_price(price)
        '<span style="font-family:monospace;">' + sprintf("%7.2f", price) + '</span>'
      end
      def cc.custom_title(title)
        '<em>' + title + '</em>'
      end
      cc.form_template = 'author_books'
    end
    root << grid_edit_widget('author') do |c|
      c.grid_options = {
        :title => 'Authors',
        # :rows => 20,
        :height => 350,
        # :pager => {:rows => 20, :rows_options => ['20','50','100']},
        :del_button => true,
        :add_button => true,
      }
      c.add_column('name', :width => 300, :sortable => true, :open_panel => true)
      c.embed_widget lambda {|x| {:author_id => x}}, book_widget
      # something like this would also work (useful if the x is something else's id)
      # c.embed_widget lambda {|x| {:author_id => Author.find(x).id}}, book_widget
      # The following would be how you add something to fill in values in an empty record,
      # e.g., to store the current user as the creator of the new record.
      # def c.before_add(record)
      #   record.user = @cell.parent_controller.user
      #   record
      # end
    end
  end
    
  def index
    super
  end
  
end