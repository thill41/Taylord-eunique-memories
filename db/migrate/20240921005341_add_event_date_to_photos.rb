class AddEventDateToPhotos < ActiveRecord::Migration[7.2]
  def change
    add_column :photos, :event_date, :date
  end
end
