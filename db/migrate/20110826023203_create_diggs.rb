class CreateDiggs < ActiveRecord::Migration
  def change
    create_table :diggs do |t|
      t.integer   :user_id
      t.integer   :pet_id
      t.integer   :value, :default => 1

      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
