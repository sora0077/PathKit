Pod::Spec.new do |s|

  s.name         = "PathKit"
  s.version      = "0.1.0"
  s.summary      = "Path representation library"

  s.homepage     = "https://github.com/sora0077/PathKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "sora0077" => "" }
  s.source       = { :git => "https://github.com/sora0077/PathKit.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/**/*.{swift}"

  s.platform = :ios
  s.ios.deployment_target = '8.0'
end
