//
//  SceneDelegate.swift
//  MealsAppCustom
//
//  Created by mac on 12/10/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        let homeUseCase = Injection.init().provideHome()
        
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }


}

