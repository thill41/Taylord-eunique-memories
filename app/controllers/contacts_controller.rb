class ContactsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_packages
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.submit
      redirect_to new_contact_path, success: 'Message sent!'
    else
      render :new, error: 'There were some issues with your submission.'
    end
  end

  private

  def set_packages
    @packages = Package.order(:position, :name)
  end

  def contact_params
    params.require(:contact).permit(:event_date,
                                    :event_type,
                                    :email,
                                    :first_name,
                                    :last_name,
                                    :message,
                                    :package_id,
                                    :phone,
                                    :reference)
  end
end
