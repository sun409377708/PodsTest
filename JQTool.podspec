

Pod::Spec.new do |s|



  s.name         = "JQTool"
  s.version      = "1.0.1"
  s.summary      = "JQTool测试"


  s.description  = "AFN的二..."

  s.homepage     = "https://github.com/sun409377708/PodsTest"


  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }



  s.author             = { "cjg" => "674149625@qq.com" }


  s.platform     = :ios, "9.0"


  s.source       = { :git => "https://github.com/sun409377708/PodsTest.git", :tag => "#{s.version}" }



  s.source_files  = "TestApp/JQTool/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.frameworks = "Foundation, "UIKit"
  s.requires_arc = true
 # s.dependency 'AFNetworking'

end
