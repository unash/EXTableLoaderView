Pod::Spec.new do |s|
  s.name         = "EXTableLoaderView"
  s.version      = "0.0.1"
  s.summary      = "基于EGOTableViewPullRefresh完善的下拉刷新上拉加载功能库."
  s.homepage     = "https://github.com/unash/EXTableLoaderView.git"
  s.author       = { "unash" => "unash@exbye.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/unash/EXTableLoaderView.git", :branch => "master" }
  s.source_files  = "EXTableLoaderView/*.{h,m}"
end