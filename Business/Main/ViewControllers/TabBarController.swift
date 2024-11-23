//
//  TabBarController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 16.11.24.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()

    }
    private func configureTabBar() {
        let firstController = MainController(viewModel: MainViewModel())
        let secondController = SecondController()
        firstController.tabBarItem = UITabBarItem(title: "Home", image: UIImage (systemName: "house.fill"), tag: 0)
        secondController.tabBarItem = UITabBarItem(title: "More", image: UIImage (systemName: "ellipsis.circle"), tag: 0)
        viewControllers = [firstController,secondController]
    }
    
}
