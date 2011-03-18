class BooksController < BaseController
  # include a helper that can render a little check mark
  helper :books
  
  has_widgets do |root|
    root << grid_edit_widget('book') do |c|
      # set the grid display options
      c.grid_options = {
        :title => 'Books',
        :height => 350,
        :del_button => true,
        :add_button => true,
      }
      # set includes to eager-load author so that we can use author.name as a column
      c.includes = :author
      # define the columns
      c.add_column('title', :width => 250, :sortable => true, :open_panel => true, :custom => :custom_title)
      c.add_column('price', :label => 'Price (USD)', :width => 75, :sortable => true, :custom => :custom_price)
      c.add_column('author.name', :width => 150, :sortable => true, :custom => :custom_author)
      c.add_column('read', :width => 75, :sortable => true, :toggle => true, :custom => :custom_check)
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
        '<span style="font-family:monospace;">' + sprintf("%7.2f", price) + '</span>' rescue '[Unset]'
      end
      def c.custom_title(title)
        '<em>' + title + '</em>' rescue '[Unset]'
      end
      def c.custom_author(author)
        author.split(%r{,\s*}).inject("") {|s,x| s = x + " #{s}"} rescue 'author not set!'
      end
      def c.caption
        "Books&mdash;#{Book.count} things you haven\\'t read."
      end
      # What you'd really use this for is for saving user_id, probably.
      def c.create_attributes
        {:title => 'Random number: ' + rand.to_s}
      end
      
    end
  end
  
  def index
    # render inline without a template
    super
  end
  
  
  
end