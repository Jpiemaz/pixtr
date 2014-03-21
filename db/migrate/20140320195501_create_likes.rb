class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :image, index: true
    end
  end
end
