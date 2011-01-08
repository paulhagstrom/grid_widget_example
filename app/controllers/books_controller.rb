class BooksController < BaseController

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
      c.add_column('price', :width => 150, :sortable => true)
      c.add_column('author.name', :width => 150, :sortable => true)
    end
  end
    
  def index
    super
  end
  
end