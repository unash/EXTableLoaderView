Pod::Spec.new do |s|
  s.name         = "EXTableLoaderView"
  s.version      = "0.1.0"
  s.summary      = "基于EGOTableViewPullRefresh完善的下拉刷新上拉加载功能库."
  s.homepage     = "https://github.com/unash/EXTableLoaderView.git"
  s.license      = { :type => 'MIT License', :file => 'LICENSE' }
  s.author       = { "unash" => "unash@exbye.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/unash/EXTableLoaderView.git", :tag => "0.1.0" }
  s.source_files  = "EXTableLoaderView/*.{h,m}"
end