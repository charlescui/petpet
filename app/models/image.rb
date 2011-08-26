class Image < ActiveRecord::Base
  belongs_to    :pet

  has_attached_file :image,
                    :url => "/image/:id/:style_:basename.:extension",
                    :path => File.join(Rca::Application.config.petpet[:lfs][:image],"/:id/:style_:basename.:extension"),
                    :styles => { 
                                 :small => "50x50>",
                                 :medium => "150*150>",
                                 :large => "300x300>"
                                }
  validates_attachment_size :image, :less_then => 2.megabytes
  validates_attachment_content_type :image,:content_type => ['image/jpg','image/jpeg','image/png'],:allow_nil => false
end
