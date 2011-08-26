class User < ActiveRecord::Base
  has_many    :providers
  has_many    :pets
  has_many    :diggs
end
