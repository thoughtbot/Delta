Pod::Spec.new do |spec|
  spec.name = "Delta"
  spec.version = "1.0.0"
  spec.summary = "Managing state is hard. Delta aims to make it simple."
  spec.homepage = "https://github.com/thoughtbot/Delta"
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors = {
    "Jake Craige" => "james.craige@gmail.com",
    "Giles Van Gruisen" => "giles@thoughtbot.com",
    "thoughtbot" => nil,
  }
  spec.social_media_url = "http://twitter.com/thoughtbot"

  spec.source = { :git => "https://github.com/thoughtbot/Delta.git", :tag => "v#{spec.version}", :submodules => true }
  spec.source_files = "Sources/**/*.{h,swift}"
  spec.requires_arc = true
  spec.platform = :ios
  spec.ios.deployment_target = "8.0"
end
