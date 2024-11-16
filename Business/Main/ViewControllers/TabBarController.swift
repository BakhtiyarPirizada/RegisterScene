//
//  TabBarController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 16.11.24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func configureTabBar() {
        let firstController = MainController()
        let secondController = SecondController()
        viewControllers = [firstController,secondController]
    }
    
}
