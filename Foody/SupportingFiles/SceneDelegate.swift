//
//  SceneDelegate.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        
        let isFirstTimeUser = checkIfFirstTimeUser() // İlk kez kullanıcı mı?
        
        if isFirstTimeUser {
            self.goToController(with: OnboardingViewController())
        } else {
            if Auth.auth().currentUser == nil {
                self.goToController(with: LoginViewController()) 
            } else {
                self.goToController(with: TabBarController())
            }
        }
    }
    
    private func checkIfFirstTimeUser() -> Bool {
        let isFirstTime = UserDefaults.standard.bool(forKey: "isFirstTimeUser")
        if !isFirstTime {
            UserDefaults.standard.set(true, forKey: "isFirstTimeUser")
        }
        return !isFirstTime
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = viewController
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
}
