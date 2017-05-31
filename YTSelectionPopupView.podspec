Pod::Spec.new do |s|
  s.name             = 'YTSelectionPopupView'
  s.version          = '1.0.0'
  s.summary          = 'YTSelectionPopupView is a popup view which is an alternative of picker view. '
  s.homepage         = 'https://github.com/yigit26/YTSelectionPopupView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yigit Can Ture' => 'yigit.ture@gmail.com' }
  s.source           = { :git => 'https://github.com/yigit26/YTSelectionPopupView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'YTSelectionPopupView/Classes/**/*.{swift}'
  s.resource_bundles = {
     'YTSelectionPopupView' => ['YTSelectionPopupView/Classes/**/*.{storyboard,xib,xcassets,json,imageset,png}']
  }
  s.module_name  = 'YTSelectionPopupView'
  s.requires_arc = true
  s.platform     = :ios, '9.0'
end
