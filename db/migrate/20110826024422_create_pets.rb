class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer   :user_id
      t.string	  :nickname
      t.string    :introduce, :limit => 1024
      t.integer   :age
      t.datetime  :birthday
      # 0 => boy
      # 1 => girl
      t.integer   :gender

      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
