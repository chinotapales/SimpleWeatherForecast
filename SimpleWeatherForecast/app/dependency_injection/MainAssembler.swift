//
//  MainAssembler.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import Moya

class MainAssembler {
    
    static let shared = MainAssembler()
    
    var provider: Provider!
    var providerStubbed: Provider!
    
    private var mainViewController: MainViewController!
    
    init() {
        initProvider()
        initProviderStubbed()
    }
    
    private func initProvider() {
        let networkLoggerPlugin = NetworkLoggerPlugin()
        provider = Provider(plugins: [networkLoggerPlugin])
    }
    
    private func initProviderStubbed() {
        let networkLoggerPlugin = NetworkLoggerPlugin()
        providerStubbed = Provider(plugins: [networkLoggerPlugin], stub: true)
    }
    
    // MARK: - MainViewController
    
    func resolveMainViewController() -> MainViewController {
        let vc = MainViewController.instanciate()
        let repository = ContentRepository(provider: provider)
        let presenter = MainPresenter(view: vc, repository: repository)
        
        mainViewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
}
