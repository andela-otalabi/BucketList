class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done
      belongs_to :bucketlist
      t.timestamps null: false
    end
  end
end
