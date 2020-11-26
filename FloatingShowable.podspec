Pod::Spec.new do |s|
    s.name             = 'FloatingShowable'
    s.version          = '0.0.1'
    s.summary          = '🎈This is a support kit that helps you develop a picture-in-picture-like view.'

    s.homepage         = 'https://github.com/AkkeyLab/FloatingShowable'
    s.license          = 'MIT'
    s.author           = 'AkkeyLab'
    s.source           = { :git => 'https://github.com/AkkeyLab/FloatingShowable.git', :tag => "#{s.version}" }
    s.social_media_url = 'https://twitter.com/AkkeyLab'

    s.platform         = :ios, "11.0"
    s.swift_version    = "5.0"

    s.module_name      = "FloatingShowable"

    s.source_files     = 'Source/**/*'
end
