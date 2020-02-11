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

 // start one instance and inject the others as we go on
                 // it is a generic type
 // in order to do the MODEL NEEDS to be exquatable AND codable
 
 private var dataPersistence = DataPersistence<Article>(filename: "savedArticle.plist")
 //setting up datapersistence instence
 /*
  places that need the injection
     - the newsFeedController needs it because detail is segued from the newsFeedController.
     - the saved view controller also needs it because it will be retrieving the data from the savedArticle.plist location
  */
 
 
 private lazy var flashCardVC: FlashCardsController = {
     
     let controller = FlashCardsController()
     controller.tabBarItem = UITabBarItem(title: "cards", image: UIImage(systemName: "eyeglasses"), tag: 0)
     // MARK:  this is where the injection happens
     // newsfeed passes it over to detail.. just incase..
     controller.dataPersistence = dataPersistence
     return controller
     
 }()
 
 private lazy var createVC: CreateController = {
      
      let controller = CreateController()
      controller.tabBarItem = UITabBarItem(title: "create", image: UIImage(systemName: "folder"), tag: 1)
     
     // from the variable that was created in the controller we are now HERE injecting the persistence from the dataPersistence from the top
     controller.dp = dataPersistence
     // everything here gets initialized right away so we need to set the delegate here so that way the DELEGATE gets immdietely recoginzed so that way it starts listening immedietly
     
     // view did load only gets opened ONLY ONCE the controller gets opened but we WANT it to it to start listening immdietly because when they save in the detail controller the saved controller is not opened yet but we still want it to recoginzed..
     // below is where the DELEGATE gets declared...
     controller.dp.delegate = controller
      // if we dont do it here then unless the
      return controller
      
  }()
 
 private lazy var searchVC: SearchController = {
      let controller = SearchController()
      controller.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "gear"), tag: 2)
     
      return controller
      
  }()
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     // MARK: this is where you embeed the controller
     viewControllers = [UINavigationController(rootViewController: flashCardVC), createVC, searchVC
    
    ]
 }
    

   

}
