# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AIgirlfriend' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for AIgirlfriend

  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'NVActivityIndicatorView', '~> 4.8.0'
  pod 'Firebase/Messaging'
  pod 'CountryPickerView'
  pod 'ISEmojiView'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'GoogleSignIn'
  pod 'Alamofire'
  pod 'SocketRocket'
  pod 'InstantSearchVoiceOverlay'
  pod 'NVActivityIndicatorView'
  
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
  
end
