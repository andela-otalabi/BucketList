class AddBucketlistToItem < ActiveRecord::Migration
  def change
    add_column :items, :bucketlist_id, :integer
  end
end
