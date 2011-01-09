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
      c.add_column('title', :width => 250, :sortable => true, :open_panel => true, :custom => :custom_title)
      c.add_column('price', :label => 'Price (USD)', :width => 75, :sortable => true, :custom => :custom_price)
      c.add_column('author.name', :width => 150, :sortable => true, :custom => :custom_author)
      c.add_column('read', :width => 50, :sortable => true, :toggle => true, :custom => :custom_check)
      c.add_filter_group 'prices', :name => 'Price categories', :exclusive => true, :columns => 2 do |f|
        f.add_filter 'cheap', :where => ["price < 10"], :default => true
        f.add_filter 'pricy', :where => ["price >= 10"]
      end
      c.add_filter_group 'authors', :where => lambda {|x| {:author_id => x }}, :columns => 4 do |f|
        Author.all.each do |author|
          f.add_filter author.id, author.name
        end
      end
      def c.custom_price(price)
        '<span style="font-family:monospace;">' + sprintf("%7.2f", price) + '</span>'
      end
      def c.custom_title(title)
        '<em>' + title + '</em>'
      end
      def c.custom_author(author)
        author.split(%r{,\s*}).inject("") {|s,x| s = x + " #{s}"}
      end
    end
  end
    
  def index
    super
  end
  
end