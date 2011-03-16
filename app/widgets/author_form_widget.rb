class AuthorFormWidget < GridEditWidget
  # this is an extended version of GridEditWidget to handle the author form in the extended books
  # controller.  In principle, this could have been all done inside a config block in the
  # extended books controller, but since a few things needed to be overridden it seemed cleaner
  # to separate it out into its own widget
  
  # set the default form_template
  # The reason for doing this here (rather than just in the config block in a controller)
  # was so that two different controllers could make use of this (e.g., books controller and
  # agents controller, where books and agents each belong_to author) without both having to
  # set the same option.
  def setup(*)
    super
    @form_template = 'extended_book_author'
  end
  
  # find_or_add_main needs to be defined, returns the main id.  See e.g., students_controller
  
  def after_form_update(options)
    main_id = find_or_add_main(options)
    # If the person was new, add contact and note
    if options[:was_new]
      new_contact = Contact.create(:person_id => options[:record].id,
        :contact_category => ContactCategory.where(:email => true).first,
        :data => "#{record.bulogin}@bu.edu")
    end
    trigger :display_form, {:pid => options[:record].id, :id => main_id}
    super(options)
  end
  
end
