import SwiftUI
import UIKit
import Amplify
import AWSDataStorePlugin

@main
struct Second_WalletApp: App {
    @State private var showHome: Bool = false
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            if showHome {
                HomeView()
            }
        }
    }
    
    func configureAmplify() {
        do {
            try Amplify.add(
                plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels())
            )
            try Amplify.configure()
            
            showHome = true
        } catch {
            fatalError("could not initialize Amplify - \(error)")
        }
        
    }
}
