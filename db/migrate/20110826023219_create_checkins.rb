class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer   :user_id

      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
