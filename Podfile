

source 'https://git.xzlcorp.com/daqiang/XZLDependencyPodSpecs.git'  #私有spec仓库的地址
source 'https://github.com/CocoaPods/Specs.git'  #官方仓库的地址

platform :ios, '8.0'

target "HXInvestigate" do
    
    # Uncomment this line if you're using Swift or would like to use dynamic frameworks
    # use_frameworks!
    
    #项目公共依赖库
    #pod 'XZLDependencyPackage/BaseClass/WebViewController', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Helper/Network', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Helper/Storage', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Module', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Statistics', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    pod 'XZLDependencyPackage’, ‘0.0.9’

    pod 'AFNetworking'
    pod 'ReactiveCocoa'
    pod 'Aspects'
    pod 'MagicalRecord'
    pod 'Masonry'
    pod 'HandyAutoLayout'
    pod 'JSPatch'
    pod 'Mixpanel'
    pod 'SDWebImage','~> 4.0.0-beta2'
    pod 'YYKit'

    target 'HXInvestigateTests' do
        inherit! :search_paths
        # Pods for testing
    end

    target 'HXInvestigateUITests' do
        inherit! :search_paths
        # Pods for testing
    end

end











