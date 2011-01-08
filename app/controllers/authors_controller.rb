class AuthorsController < BaseController

  has_widgets do |root|
    root << grid_edit_widget('author') do |c|
      c.grid_options = {
        :title => 'Authors',
        # :rows => 20,
        :height => 350,
        # :pager => {:rows => 20, :rows_options => ['20','50','100']},
        :del_button => true,
        :add_button => true,
      }
      c.add_column('name', :width => 150, :sortable => true, :open_panel => true)
    end
  end
    
  def index
    super
  end
  
end