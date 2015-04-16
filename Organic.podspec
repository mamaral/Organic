Pod::Spec.new do |s|

  s.name         = "Organic"
  s.version      = "0.3"
  s.summary      = "The intuitive UITableViewController."
  s.homepage     = "https://github.com/mamaral/Organic"
  s.license      = "MIT"
  s.author       = { "Mike Amaral" => "mike.amaral36@gmail.com" }
  s.social_media_url   = "http://twitter.com/MikeAmaral"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/mamaral/Organic.git", :tag => "v0.3" }
  s.source_files  = "Organic/Source/OrganicViewController.{h,m}", "Organic/Source/OrganicSection.{h,m}", "Organic/Source/OrganicCell.{h,m}"
  s.requires_arc = true

end
