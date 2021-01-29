Pod::Spec.new do |spec|
  
  spec.name         = 'GYMixtureScrollView'
  spec.version      = '0.1.0'
  spec.summary      = 'GYMixtureScrollView'
  spec.homepage     = "http://www.baidu.com"
  spec.license      = "MIT"
  spec.author       = { "zhugy781" => "zhugy781@163.com" }
  spec.social_media_url   = ""
  spec.source = {:git => 'https://github.com/Zhugongying/GYMixtureScrollView.git', :tag => spec.version}

  spec.platform = :ios,'9.0'
  spec.source_files = 'GYMixtureScrollView/GYMixtureScrollView/**/*.{h,m,mm,c}'
  
  spec.exclude_files = 'GYMixtureScrollView/GYMixtureScrollView/info.plist'
  spec.libraries = 'stdc++','resolv'
  spec.requires_arc = true
  spec.ios.deployment_target = '9.0'
  spec.pod_target_xcconfig = {
      'ENABLE_BITCODE' => 'NO',
      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
  
    
  spec.dependency 'Masonry'
  spec.dependency 'GYBaseKit'

    
end
