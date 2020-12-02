//
//  ViewController.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 31/10/20.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if let tabBarController = appDelegate.tabBarController {
//            print("ViewController - push tabBarController")
//            print(self.navigationController)
//            self.navigationController = UINavigationController()
//            self.navigationController?.pushViewController(tabBarController, animated: true)
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigate(type: .modalWithNavigation, module: GeneralRoute.splash, completion: nil)
        }
    }
}

