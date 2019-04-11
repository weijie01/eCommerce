# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'Firebase/Firestore'
	pod 'Firebase/Storage'
	pod 'CodableFirebase'
	pod 'IQKeyboardManagerSwift'
	pod 'Kingfisher', '~> 4.0'
end

target 'eCommerce' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for eCommerce
  shared_pods
  pod 'Stripe'
  pod 'Alamofire'

end

target 'eCommerceAdmin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for eCommerceAdmin
  shared_pods
  pod 'CropViewController'

end
