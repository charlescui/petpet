class User < ActiveRecord::Base
  acts_as_authentic
  has_many    :providers
  has_many    :pets
  has_many    :diggs

  def avatar(style = :medium)
    case style
    when :medium
      self.user_info.headimage_file_name ? self.user_info.headimage.url(:medium) : "/assets/default_avatar_70.png"
    when :thumb
      self.user_info.headimage_file_name ? self.user_info.headimage.url(:thumb) : "/assets/default_avatar_50.png"
    when :small
      self.user_info.headimage_file_name ? self.user_info.headimage.url(:small) : "/assets/default_avatar_24.png"
    end
  end

  def self.build_from_omniauth(hash)
    user = User.new
    case hash['provider']
    when 'tsina'
      user.name = hash["user_info"]["name"]
    when 'renren'
      user.name = hash["user_info"]["name"]
    else
      user.name = hash["user_info"]["name"] || "RCA Fans"
    end
    user
  end

  def self.create_from_omniauth(hash)
    user = self.build_from_omniauth(hash)
    user.save!
    user
  end

end
