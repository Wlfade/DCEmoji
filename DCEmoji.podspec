Pod::Spec.new do |s|
s.name = 'DCEmoji'
s.version = '1.0.4'
s.license = 'MIT'
s.summary = 'A emoji putView on iOS.'
s.homepage = 'https://github.com/Wlfade/DCEmoji'
s.authors = {'Wlfade' => '734691535@qq.com'}
s.source = {:git => 'https://github.com/Wlfade/DCEmoji.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'Emoticon/**/*.{h,m,bundle}'
s.resources = 'Emoticon/Model/Images.bundle'
end
