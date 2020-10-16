class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.integer :month
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
