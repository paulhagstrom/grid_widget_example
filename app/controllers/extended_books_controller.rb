class ExtendedBooksController < BaseController
  # This version of the books controller embeds an author panel in the books form
  # Since books belong_to authors, we allow for the possibility of creating a new book
  # only once the author has been created, but this allows for all of this to happen on
  # the same screen.  This is the situation where the :form_only option is useful.
  
  # include a helper that can render a little check mark
  helper :books
  
  has_widgets do |root|
    # the form_only option, when set, is a lambda function that allows us to find the author
    # based on the selection in book.
    author_widget = grid_edit_widget('author', :widget_id => :extended_book_author,
        :form_only => lambda {|x| Book.find(x).author_id}) do |cc|
      cc.form_template = 'extended_book_author'
    end
    # author_widget = widget(:author_form, :resource => 'author', :form_only => lambda {|x| Book.find(x).author_id})
    # # overriding find_or_add_main allows for interaction with the book model once the author is set.
    # # this could have been inside the author_form widget, but the way I designed it, the author_form
    # # widget could be re-used for a different connection (e.g., author's agents) that belongs_to author
    # # as well.
    # def author_widget.find_or_add_main(options)
    #   if options[:was_new]
    #     book = Book.create(:author_id => options[:record].id)
    #   else
    #     book = Book.where(:author_id => options[:record].id).first
    #   end
    #   book.id
    # end

    root << grid_edit_widget('book', :widget_id => :extended_book) do |c|
      c.form_template = 'extended_book'
      # set the grid display options
      c.grid_options = {
        :title => 'Books (Extended)',
        :height => 350,
        :pager => {:rows => 5, :rows_options => ['5', '10','20']},
        :del_button => true,
        :add_button => true,
      }
      # set includes to eager-load author so that we can use author.name as a column
      c.includes = :author
      # define the columns
      c.add_column('title', :width => 250, :sortable => true, :open_panel => true, :custom => :custom_title)
      c.add_column('price', :label => 'Price (USD)', :width => 75, :sortable => true, :custom => :custom_price)
      c.add_column('author.name', :width => 150, :sortable => true, :custom => :custom_author)
      c.add_column('read', :width => 50, :sortable => true, :toggle => true, :custom => :custom_check)
      # define the filters
      c.add_filter_group 'prices', :name => 'Price categories', :exclusive => true, :columns => 2 do |f|
        f.add_filter 'cheap', :where => ["price < 10"], :default => true
        f.add_filter 'pricy', :where => ["price >= 10"]
      end
      c.add_filter_group 'authors', :where => lambda {|x| {:author_id => x }}, :columns => 4 do |f|
        Author.all.each do |author|
          f.add_filter author.id, author.name
        end
      end
      # define the custom display methods
      def c.custom_price(price)
        '<span style="font-family:monospace;">' + sprintf("%7.2f", price) + '</span>'
      end
      def c.custom_title(title)
        '<em>' + title + '</em>'
      end
      def c.custom_author(author)
        author.split(%r{,\s*}).inject("") {|s,x| s = x + " #{s}"} rescue 'author not set!'
      end
      # embed the author widget
      c.embed_widget nil, author_widget
    end
  end
    
end