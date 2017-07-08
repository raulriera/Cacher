#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Cacher'
  s.version          = '1.0.0'
  s.summary          = 'Caching made easy.'

  s.description  = <<-DESC
                   Super simple caching solution for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage         = 'https://github.com/raulriera/Cacher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Raul Riera" => "rieraraul@gmail.com" }
  s.social_media_url = "http://twitter.com/raulriera"
  s.source           = { :git => 'https://github.com/raulriera/Cacher.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.watchos.deployment_target = '4.0'
  s.tvos.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'

  s.source_files  = 'Cacher/*.swift'
end
