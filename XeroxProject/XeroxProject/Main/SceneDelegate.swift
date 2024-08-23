//
//  SceneDelegate.swift
//  XeroxProject
//
//  Created by Nishanth on 07/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.rootViewHandler(windowScene: windowScene)
        
    }
    
    func rootViewHandler(windowScene: UIWindowScene){
        NetworkMonitor.sharedInstance.startMonitor()
        let loginModel = LoginViewModel()
        loginModel.onLogout = { [weak self] in
            self?.viewNavigate(windowScene: windowScene, login: false)
        }
        loginModel.isUserLogin { signin in
            if(signin){
                self.viewNavigate(windowScene: windowScene, login: signin)
            }
            else{
                self.viewNavigate(windowScene: windowScene, login: signin)
            }
        }
    }
    
    
    func viewNavigate(windowScene: UIWindowScene, login: Bool){
        let viewController: UINavigationController
            window = UIWindow(windowScene: windowScene)
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if(login){
            let vc = mainStoryBoard.instantiateViewController(identifier: "DashboardViewController") as! DashboardViewController
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.isHidden = true
            viewController = navController
        }
        else{
            let vc = mainStoryBoard.instantiateViewController(identifier: "SigninViewController") as! SigninViewController
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.isHidden = true
            viewController = navController
        }
        viewController.navigationBar.isHidden = true
        window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            UIView.transition(with: self.window!, duration: 0.5, options: [], animations: {
            }, completion: nil)
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

