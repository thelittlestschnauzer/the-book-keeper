class CreateBookLists < ActiveRecord::Migration
  def change
    create_table :book_lists do |t|
      t.string :title
      t.string :description
    end
  end
end
