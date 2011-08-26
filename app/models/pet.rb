class Pet < ActiveRecord::Base
  belongs_to    :user
  has_many      :images
  has_many      :voices
  has_many      :diggs
end
