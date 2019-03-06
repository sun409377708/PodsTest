

Pod::Spec.new do |s|



  s.name         = "SJQCalendar"
  s.version      = "1.1.6"
  s.summary      = "SJQCalendar日历"


  s.description  = "自定义日历"

  s.homepage     = "https://github.com/sun409377708/PodsTest"


  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "SJQ" => "409377708@qq.com" }


  s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/sun409377708/PodsTest.git", :tag => "#{s.version}" }



  s.source_files  = "TestApp/CCPCalendar/*.{h,m}"
  s.resources    = 'TestApp/CCPCalendar/CCPCalendar.bundle'
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

end
