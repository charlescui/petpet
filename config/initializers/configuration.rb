Petpet::Application.config.petpet = {}
Petpet::Application.config.petpet

# net file system
Petpet::Application.config.petpet[:nfs] = {}
Petpet::Application.config.petpet[:lfs] = {}
NFSBASE = "/tmp/petpet"
SYMLINKS = {
  :image => ["public","image"],
  :attachment => ["public","voice"]
}
SYMLINKS.each { |key,path|
  Petpet::Application.config.petpet[:nfs][key] = File.join(NFSBASE,*path)
  Petpet::Application.config.petpet[:lfs][key] = File.join(Rails.root,*path)
}
