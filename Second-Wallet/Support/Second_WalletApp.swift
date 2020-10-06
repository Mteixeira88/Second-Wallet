import SwiftUI
import UIKit
import Amplify
import AmplifyPlugins

@main
struct Second_WalletApp: App {
    @StateObject private var cardViewModel = CardsListViewModel()
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: cardViewModel)
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
