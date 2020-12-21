class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.date :release_day
      t.boolean :released
      t.text :rating
      t.integer :user_id
    end
  end
end
