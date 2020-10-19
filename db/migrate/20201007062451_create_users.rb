class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.integer :role, null: false, default: 1
      t.integer :delete_flag, null: false, default: 0
      t.string :reason
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_send_at

      t.timestamps
    end
  end
end
