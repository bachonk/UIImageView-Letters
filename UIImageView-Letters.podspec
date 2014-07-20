Pod::Spec.new do |s|
  s.name         = "UIImageView-Letters"
  s.version      = "1.0"
  s.summary      = "UIImageView category that generates letter initials as image."
  s.description  = "An easy, helpful UIImageView category that generates letter initials as a placeholder for user profile images, with a randomized background color."
  s.homepage     = "https://github.com/bachonk/UIImageView-Letters"
  s.screenshots  = "http://i.imgur.com/xSBjVQ7.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Tom Bachant" => "tom@dashride.com" }
  s.platform     = :ios, '7.0'
  s.source = { :git => "https://github.com/bachonk/UIImageView-Letters.git",
               :tag => 1.0 }
  s.source_files  = 'UIImageView+Letters'
  s.requires_arc = true
end
