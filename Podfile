# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!

def install_pods

  # networking
  pod 'Moya', '~> 11.0.2'
  pod 'Moya/RxSwift', '~> 11.0.2'
  pod 'Moya-ObjectMapper/RxSwift', '~> 2.7'

  #security
  pod 'KeychainSwift', '~> 11.0'

end

target 'SimpleWeatherForecast' do
	install_pods
end

target 'SimpleWeatherForecastTests' do
    pod 'Moya-ObjectMapper/RxSwift', '~> 2.7'
end
    
