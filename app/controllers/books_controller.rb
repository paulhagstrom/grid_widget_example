class BooksController < BaseController
  helper :books
  
  has_widgets do |root|
    root << grid_edit_widget('book') do |c|
      c.grid_options = {
        :title => 'Books',
        # :rows => 20,
        :height => 350,
        # :pager => {:rows => 20, :rows_options => ['20','50','100']},
        :del_button => true,
        :add_button => true,
      }
      c.includes = :author
      c.add_column('title', :width => 150, :sortable => true, :open_panel => true)
      c.add_column('price', :width => 150, :sortable => true, :custom => :custom_price)
      c.add_column('author.name', :width => 150, :sortable => true)
      c.add_column('read', :width => 50, :sortable => true, :toggle => true, :custom => :custom_check)
      c.add_filter_group 'prices', :name => 'Price categories', :exclusive => true, :columns => 2 do |f|
        f.add_filter 'cheap', :where => ["cast(price as integer) < 50"], :default => true
        f.add_filter 'pricy', :where => ["cast(price as integer) >= 50"]
      end
      c.add_filter_group 'authors', :where => lambda {|x| {:author_id => x }}, :columns => 4 do |f|
        Author.all.each do |author|
          f.add_filter author.id, author.name
        end
      end
      def c.custom_price(price)
        "$#{price}"
      end
    end
  end
    
  def index
    super
  end
  
end