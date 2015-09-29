class RemoveBucketlistIdFromBucketlist < ActiveRecord::Migration
  def change
    remove_column :bucketlists, :bucketlist_id, :integer
  end
end
