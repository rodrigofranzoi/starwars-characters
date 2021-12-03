//
//  SceneDelegate.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let tabBar = UITabBarController()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = .init(windowScene: scene)
            
            let navController = UINavigationController(rootViewController: ViewController())
            navController.tabBarItem.title = "Star Wars People"
            let img = UIImage(named: "star")
            navController.tabBarItem.image = img
        
            let navController2 = UINavigationController(rootViewController: DeveloperView())
            navController2.tabBarItem.title = "About"
            navController2.tabBarItem.image = UIImage(named: "lightsaber")
            tabBar.tabBar.backgroundColor = .white
            tabBar.setViewControllers([navController, navController2], animated: true)
            window?.rootViewController = tabBar
        }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

