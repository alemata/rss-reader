class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :channels_quantity

      t.timestamps
    end
  end
end
