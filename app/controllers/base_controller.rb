# The BaseController is the base class for the grid_widget-using controllers.
# It provides an index action that allows calling super to just display the widget within the layout.
#
# The normal form of a subclass will be
#
#   has_widgets do |root|
#     root << grid_edit_widget('contact_category') do |c|
#       [...configuration options...]
#     end
#   end
# 
#   def index
#     super
#   end
#
# If you explicitly name the widget something else, or if the resource is not the singular
# version of the controller name, then you can call super with an explicit widget name.
# If you want to have a real index view, just don't call super.

class BaseController < ApplicationController
  layout 'grid_frame'
  include GridWidget::ControllerMethods
  
  # In order to avoid a bunch of essentially contentless view files, you can
  # render inline by calling super widget_name from a subclassed controller.
  # If no widget name is provided, it will guess that the widget is called like
  # the un-namespaced singularized controller. That is, admin/people becomes person.
  def index(wid = nil)
    if wid
      render :layout => 'grid_frame', :inline => "<%= render_widget '#{wid}' %>"
    else
      # TODO consider trying to use self.class.name.underscore.gsub(/_controller$/,'') here, if it works
      render :layout => 'grid_frame',
        :inline => "<%= render_widget '#{params[:controller].split('/').last.singularize}' %>"
    end
  end
    
end
