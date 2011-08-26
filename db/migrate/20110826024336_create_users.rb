class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :uid
      t.string    :name
      t.string    :avatar

      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
