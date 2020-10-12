class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :month
      t.integer :spending_category, null: false, default: 0
      t.integer :type_money, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.float :moneys
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :plans, [:user_id, :month]
  end
end
