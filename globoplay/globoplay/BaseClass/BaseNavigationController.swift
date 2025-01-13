//
//  BaseNavigationController.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    init(rootViewController: UIViewController, title: String, tabBarImageName: String) {
        super.init(rootViewController: rootViewController)
        self.setupTabBar(title, tabBarImageName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedTheme()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func updatedTheme() {
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .black
    }
    
    private func setupTabBar(_ title: String, _ tabBarImageName: String) {
        tabBarItem.title = title
        tabBarItem.image = UIImage(named: tabBarImageName)
    }
}
