//
//  TabBarController.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
     case splash
}

extension GeneralRoute {
    var module: UIViewController? {
         switch self {
         case .splash:
            return SplashViewController()
         }
    }
}


fileprivate extension UINavigationController {
    func configurationTabBar(typeTabBar: NavigationTypes) {
        self.navigationBar.tintColor = UIColor.orange
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        let image = "\(typeTabBar.imageName)"
        print(typeTabBar.imageName)
        self.setupTabBarItem(title: nil,
            imageName: image,
            selectedImageName: image)

        self.viewControllers = [typeTabBar.controller]
    }
    
    func setupTabBarItem(title: String?,
        imageName: String,
        selectedImageName: String
    ) {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysTemplate)
        tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarController?.tabBar.tintColor = UIColor(red: 44/255, green: 92/255, blue: 200/255, alpha: 1)
        tabBarController?.tabBar.unselectedItemTintColor = UIColor(red: 181/255, green: 191/255, blue: 199/255, alpha: 1)
    }
}

fileprivate enum NavigationTypes {
    case home
    case favourites
    case search
    case settings

    public var key: String {
        switch self {
        case .home:
            return "tabBar-home"
        case .favourites:
            return "tabBar-stack"
        case .search:
            return "tabBar-compass"
        case .settings:
            return "tabBar-settings"
        }
    }

    public var imageName: String {
        switch self {
        case .home:
            return "tabbar-home"
        case .favourites:
            return "tabbar-stack"
        case .search:
            return "tabbar-compass"
        case .settings:
            return "tabbar-settings"
        }
    }

    var controller: UIViewController {
        switch self {
        case .home:
            return GalleryViewController()
        case .favourites:
            return FavoritesViewController()
        case .search:
            return FavoritesViewController()
        case .settings:
            return FavoritesViewController()
        }
    }
}

public class CustomBarController: UITabBarController {
    let homeNavController = UINavigationController()
    let navFavoritesController = UINavigationController()
    let navSearchController = UINavigationController()
    let navSettingsController = UINavigationController()

    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("CustomBarController - init")
    }

    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        print("CustomBarController - viewDidLoad")
        self.homeNavController.configurationTabBar(typeTabBar: .home)
        self.navFavoritesController.configurationTabBar(typeTabBar: .favourites)
        self.navSearchController.configurationTabBar(typeTabBar: .search)
        self.navSettingsController.configurationTabBar(typeTabBar: .settings)
        self.viewControllers = [self.homeNavController,
                                self.navFavoritesController,
                                self.navSearchController,
                                self.navSettingsController]
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(red: 44/255, green: 92/255, blue: 200/255, alpha: 1)
        self.selectedIndex = 0
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
