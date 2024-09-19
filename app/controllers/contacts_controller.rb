class ContactsController < ApplicationController
  skip_before_action :authenticate_user!
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

  def contact_params
    params.require(:contact).permit(:event_type,
                                    :first_name,
                                    :last_name,
                                    :event_date,
                                    :email,
                                    :phone,
                                    :reference,
                                    :message)
  end
end
