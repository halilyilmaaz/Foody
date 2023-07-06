//
//  TabBarViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs(){
//        let profileView = ProfilView()
//        let profileViewController = UIHostingController(rootView: profileView),

        viewControllers = [
            createNavController(for: HomeViewController(), title: "Foody", image: UIImage(systemName: "house")!),
            createNavController(for: SearchViewController(), title: "", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: ProfilViewController(), title: "", image: UIImage(systemName: "person")!)
        ]
        
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navControler = UINavigationController(rootViewController: rootViewController)
        navControler.tabBarItem.title = title
        navControler.tabBarItem.image = image
        navControler.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navControler
    }

}
