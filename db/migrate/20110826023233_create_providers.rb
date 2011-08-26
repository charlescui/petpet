class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string      :provider
      t.string      :uid
      t.string      :token
      t.string      :secret
      t.integer     :user_id
      t.binary      :metadata, :limit => 1024

      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
