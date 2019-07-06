class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :point
      t.integer :meld
      t.integer :riichi
      t.integer :rank

      t.timestamps
    end
  end
end
