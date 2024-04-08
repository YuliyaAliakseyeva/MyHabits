//
//  TabBarController.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 7.03.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    var habitsNavigationController: UINavigationController!
    var infoNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        habitsNavigationController = UINavigationController(rootViewController: HabitsViewController())
        infoNavigationController = UINavigationController(rootViewController: InfoViewController())
        
        self.viewControllers = [
            habitsNavigationController,
            infoNavigationController
        ]
        
        let habitsItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "note.text"),
            tag: 0
        )
        
        let infoItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle"),
            tag: 1
        )
        
        habitsNavigationController.tabBarItem = habitsItem
        infoNavigationController.tabBarItem = infoItem
        
    }
}
