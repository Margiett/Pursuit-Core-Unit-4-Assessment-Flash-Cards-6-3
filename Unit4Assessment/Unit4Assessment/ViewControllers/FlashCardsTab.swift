//
//  FlashCardsTab.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsTab: UITabBarController {
 
    //MARK: Step 1: setting up data persistence and its delegate
 private var dataPersistence = DataPersistence<FlashCardModel>(filename: "savedFlashCards.plist")
    
    private var userPreference = UserPreference()
 
 private lazy var flashCardVC: FlashCardsController = {
    let viewController = FlashCardsController()
    viewController.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName:
        "questionmark.circle"), tag: 0)
    viewController.dataPersistence = dataPersistence
    return viewController
     
 }()
  
 private lazy var createVC: CreateController = {
      
      let controller = CreateController()
      controller.tabBarItem = UITabBarItem(title: "create", image: UIImage(systemName: "square.and.pencil"), tag: 1)
    //controller.dataPersistence = dataPersistence
    controller.createVar = dataPersistence
    
    //MARK: why is not working !!!!!!!! Come back to it !!
    // step 6: setting up data persistence and its delegate
      // controller.dataPersistence.delegate = controller
    
    
    //controller.createVar.delegate = controller as! DataPersistenceDelegate
//     controller.dp = dataPersistence
//     controller.dp.delegate = controller
 
      return controller
      
  }()
 
 private lazy var searchVC: SearchController = {
      let controller = SearchController()
      controller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "gear"), tag: 2)
     
      return controller
      
  }()
 
 override func viewDidLoad() {
     super.viewDidLoad()
    view.backgroundColor = .systemBackground
     
     // MARK: this is where you embeed the controller
    
    viewControllers = [UINavigationController(rootViewController: flashCardVC),
                       UINavigationController(rootViewController: createVC),
                       UINavigationController(rootViewController: searchVC)
    
    ]
 }
    

   

}
