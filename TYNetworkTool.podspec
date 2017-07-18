
Pod::Spec.new do |s| 
  s.name         = "TYNetworkTool"
  s.version      = "0.0.1"
  s.homepage	 = "https://github.com/TianyongWang/TYNetworkTool"
  s.summary      = "A short description of TYNetworkTool."
  s.license	 = "MIT"
  s.author       = { "MasazumiQi" => "47940062@qq.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/TianyongWang/TYNetworkTool.git" ,:tag => "#{s.version}"}
  s.requires_arc = true
  s.source_files = "TYNetworkTool/TYNetworkTool/*.{h.m}"
  s.frameworks   = "UIKit","Foundation"
  s.dependency "AFNetworking"
  s.dependency "YYCache"
end

