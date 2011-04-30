class AuthorsController < BaseController

  # the authors setup has a books widget inside an authors widget
  # define the books widget first, then we will embed that in the authors widget
  has_widgets do |root|
    book_widget = grid_edit_widget('book') do |cc|
      cc.grid_options = {
        :title => 'Books',
        :height => 150,
        :del_button => true,
        :add_button => true,
      }
      cc.add_column('title', :width => 350, :sortable => true, :open_panel => true, :custom => :custom_title, :spokesfield => true)
      cc.add_column('price', :label => 'Price (USD)', :width => 75, :sortable => true, :custom => :custom_price)
      cc.add_column('read', :width => 50, :sortable => true, :toggle => true, :custom => :custom_check)
      def cc.custom_price(price)
        '<span style="font-family:monospace;">' + sprintf("%7.2f", price) + '</span>' rescue '[Unset]'
      end
      def cc.custom_title(title)
        '<em>' + title + '</em>' rescue '[Unset]'
      end
      # If the custom above had instead been defined to take two arguments, the second
      # would get the whole record, e.g. def cc.custom_title(title, record)
      # Below, we set the template to 'author_books' to distinguish the books form inside the authors
      # widget from the books form on the books page.  The only real difference between them here
      # in the example app is that the author_books form does not contain the author field (since
      # that value can be assumed based on which author is being edited).
      cc.form_template = 'author_book'
    end
    # now define the author widget
    root << grid_edit_widget('author') do |c|
      c.grid_options = {
        :title => 'Authors',
        :height => 350,
        :del_button => true,
        :add_button => true,
      }
      c.add_column('name', :width => 500, :sortable => true, :open_panel => true)
      # embed the books widget that we built before as a child of the author widget.
      # embed_widget adds the child but also makes the necessary event response connections
      # the first argument (the lambda function) tells the book widget how to narrow
      # its selection to just relevant books (books by the selected author).
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
  
  # render this inline without a template file
  def index
    super
  end
  
end