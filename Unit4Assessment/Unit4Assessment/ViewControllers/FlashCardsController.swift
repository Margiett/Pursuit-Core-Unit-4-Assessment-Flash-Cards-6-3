//
//  FlashCardsController.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


class FlashCardsController: UIViewController {

public var dataPersistence: DataPersistence<FlashCard>!
    
    private let flashCardView = CardsView()
    
    private var newsArticles = [FlashCard]() {
        didSet{
            DispatchQueue.main.async {
                //data for the collection view

                      self.flashCardView.collectionV.reloadData()
                  }
        }
    }

}
