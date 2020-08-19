
Pod::Spec.new do |spec|

  spec.name         = "LGAlert"
  spec.version      = "1.0.2"
  spec.summary      = "iOS自定义弹窗"
  spec.description  = <<-DESC
  TODO: 这是一个自定义弹窗
                   DESC

  spec.homepage     = "https://github.com/qiaomenzhuan/LGAlert"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "yanglei" => "18500123278@163.com" }
  spec.social_media_url   = "https://github.com/qiaomenzhuan"
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/qiaomenzhuan/LGAlert.git", :tag => "#{spec.version}" }
  spec.source_files  = 'LEIAlert'
  spec.exclude_files = "Classes/Exclude"

end
