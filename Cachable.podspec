#
#  Be sure to run `pod spec lint Cacher.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "Cachable"
  s.version      = "1.2.0"
  s.summary      = "Super simple caching solution for iOS, macOS, tvOS and watchOS"

  s.homepage     = "https://github.com/raulriera/Cacher"
  s.license      = {:type => "MIT", :file => "LICENSE"}

  s.author    = "Raul Riera"
  s.social_media_url   = "https://twitter.com/raulriera"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/raulriera/Cacher.git", :tag => "#{s.version}" }
  s.source_files  = ["Cacher/Cacher.swift", "Cacher/Cacher.h"]
  s.public_header_files = ["Cacher/Cacher.h"]

  s.resources = "Resources/*.png"
  s.requires_arc = true

end
