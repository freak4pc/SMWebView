Pod::Spec.new do |s|
  s.name             = "SMWebView"
  s.version          = "1.0"
  s.summary          = "SMWebView is a delightful, lightweight Swift wrapper around UIWebView that lets you harness the power of Closures and Chaining. "

  s.description      = <<-DESC
                      SMWebView is a delightful, lightweight Swift wrapper around UIWebView that lets you harness the power of Closures and Chaining. 
                      And of course - Get rid of those pesky, awful delegates ;-) 
                       DESC

  s.homepage         = "https://github.com/freak4pc/SMWebView"
  s.license          = 'MIT'
  s.author           = { "freak4pc" => "freak4pc@gmail.com" }
  s.source           = { :git => "https://github.com/freak4pc/SMWebView.git", :tag => s.version }
  s.social_media_url = 'http://i.imgur.com/1PFc32m.jpg'

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source_files     = '*.swift'
end
