//
//  SettingsViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 17.07.2023.
//

import UIKit

import FirebaseAuth

class SettingsViewModel {
    
    var didDeleteAccountCallBack: (() -> Void)?
    
    func didTapLogOut() {
        AuthService.shared.logOut { [weak self] error in
            guard self != nil else {
                return
            }
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    let splashScreenViewController = LoginViewController()
                    let newNavigationController = UINavigationController(rootViewController: splashScreenViewController)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = newNavigationController
                    }
                }
            }
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        
        // Firebase Authentication'dan oturumu sonlandır
        do {
            try Auth.auth().signOut()
        } catch {
            self.didDeleteAccountCallBack?()
            return
        }
        // Kullanıcıyı Firebase'den sil
        user?.delete { error in
            self.didDeleteAccountCallBack?()
        }
    }
}
