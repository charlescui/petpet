class CreateVoices < ActiveRecord::Migration
  def change
    create_table :voices do |t|
      t.integer   :pet_id
      t.string    :description
      t.string    :voice_file_name
      t.string    :voice_content_type
      t.integer   :voice_file_size
      t.datetime  :voice_updated_at

      t.timestamps
    end
  end
end
