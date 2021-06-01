platform :ios, '10.0'
workspace 'TerraFirstHands.xcworkspace'
$TekoSpecs = 'https://' + ENV['GITHUB_USER_TOKEN'] + '@github.com/teko-vn/Specs-ios.git'   # for using pods from Teko
source 'https://github.com/CocoaPods/Specs.git' # for using pods from cocoaPods
source $TekoSpecs   # for using pods from Teko

def terraPods
  pod 'Terra', '~> 2.5.3', source: $TekoSpecs
end

def userPods 
  pod 'TekIdentityService'
  pod 'TekUserService'
end

def janusPods
  pod 'Janus', '~> 3.2.1'
  pod 'JanusFacebook', '~> 3.2.3', source: $TekoSpecs
  pod 'JanusGoogle', '~> 3.2.3', source: $TekoSpecs
  pod 'JanusFacebook', '~> 3.2.3', source: $TekoSpecs
  pod 'JanusApple', '~> 3.2.3', source: $TekoSpecs
end

def minervaPods
  pod 'Minerva', '~> 3.8.2', source: $TekoSpecs 
  pod 'MinervaUI', '~> 3.8.2', source: $TekoSpecs 
end

def apolloPods
  pod 'Apollo', '~> 0.4.22', :source => $TekoSpecs
  pod 'ApolloTheme', '~> 0.0.2'
end

def trackPods
  pod 'TekoTracker', '~> 0.7.5', :source => $TekoSpecs
end

# bitcode enable
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # set valid architecture
      config.build_settings['VALID_ARCHS'] = 'arm64 armv7 armv7s x86_64'

      # build active architecture only (Debug build all)
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['ENABLE_BITCODE'] = 'YES'

      # Xcode12 have to exclude arm64 for simulator architecture
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings["BUILD_LIBRARY_FOR_DISTRIBUTION"] = "YES"
      config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'

      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      cflags << '-fembed-bitcode'
      config.build_settings['OTHER_CFLAGS'] = cflags
    end
  end
end

target 'TerraFirstHands' do
  use_frameworks!
  userPods
  terraPods  
  janusPods
  minervaPods
  trackPods
  apolloPods
  pod 'DropDown'
  pod 'LoyaltyCore'
  pod 'LoyaltyConsumer'
  pod 'LoyaltyConsumerUI'
pod ‘IQKeyboardManagerSwift’
end

