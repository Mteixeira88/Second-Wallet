//
//  Second_WalletApp.swift
//  Second-Wallet
//
//  Created by Miguel Teixeira on 29/07/2020.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct Second_WalletApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
    func configureAmplify() {
        do {
            try Amplify.add(
                plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels())
            )
            
            try Amplify.configure()
        } catch {
            fatalError("could not initialize Amplify - \(error)")
        }
        
    }
}
