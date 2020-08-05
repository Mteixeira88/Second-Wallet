# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Second-Wallet' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Second-Wallet

  #Amplify
  pod 'Amplify'
  pod 'Amplify/Tools'
  pod 'AmplifyPlugins/AWSDataStorePlugin'
  pod 'Introspect'

  target 'Second-WalletTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Second-WalletUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
