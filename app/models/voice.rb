class Voice < ActiveRecord::Base
  belongs_to    :pet

  has_attached_file :voice,
                    :url => "/voice/:id/:style_:basename.:extension",
                    :path => File.join(Rca::Application.config.petpet[:lfs][:voice],"/:id/:style_:basename.:extension"),
                    :processors => [:mpeg]

  validates_attachment_size :voice, :less_then => 2.megabytes
  #validates_attachment_content_type :voice, :content_type => ['image/jpg','image/jpeg','image/png'], :allow_nil => false

end
