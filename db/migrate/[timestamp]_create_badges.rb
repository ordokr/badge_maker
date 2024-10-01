class CreateBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :description
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
