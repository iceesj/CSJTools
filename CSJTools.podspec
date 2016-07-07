Pod::Spec.new do |s|

  s.name          = "CSJTools"
  s.version       = "0.1.7"
  s.license       = "MIT"
  s.summary       = "曹盛杰Cocoa工具包"
  s.homepage     = 'https://github.com/iceesj/CSJTools'
  s.author        = { "Cao Shengjie" => "iceesj@163.com" }
  s.source       = { :git => 'https://github.com/iceesj/CSJTools.git', :tag => '0.1.7' }
  s.source_files  = "CSJTools/*"
  s.platform      = :ios, '8.0'
  s.framework     = 'CoreData'
  
  s.prefix_header_contents = '#import <CoreData/CoreData.h>'
  s.requires_arc = true
  
end