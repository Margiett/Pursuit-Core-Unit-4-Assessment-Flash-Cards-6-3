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

public var dataPersistence: DataPersistence<FlashCardModel>!
    
    private let flashCardView = CardsView()
    
    private var newsCardsDidSet = [FlashCardModel]() {
        didSet{
            self.flashCardView.collectionView.reloadData()
            if newsCardsDidSet.isEmpty {
                flashCardView.collectionView.backgroundView = EmptyView(title: "Flash Cards", message: "Flash Cards were not saved")
            } else {
                flashCardView.collectionView.backgroundView = nil
                
            }
        }
    }
    override func loadView() {
        view = flashCardView
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
          delegateAndDataSources()
        flashCardView.collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "FlashCardCell")
        view.backgroundColor = .cyan
        
      }
    
    
      func delegateAndDataSources(){
        flashCardView.collectionView.delegate = self
        flashCardView.collectionView.dataSource = self
      }
    

}

extension FlashCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCardsDidSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashCardCell", for: indexPath) as? FlashCardCell else{
            fatalError("failed to downcast to FlashCard Cell")
        }
        
        let selectedFlashCard = newsCardsDidSet[indexPath.row]
        cell.configureCell(for: selectedFlashCard)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension FlashCardsController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize:CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 8
        let numberOfItems:CGFloat = 1
        let itemHeight:CGFloat = maxSize.height * 0.3
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension FlashCardsController: FlashCardButtonDelegate{
    func moreButtonPressed(_ collectionViewCell: FlashCardCell, flashCard: FlashCardModel) {
        let actionSheet = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete \(flashCard.quizTitle)?", style: .destructive) { (alertAction) in
            self.deleteFlashCard(flashCard)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actions = [deleteAction, cancelAction]
        actions.forEach { actionSheet.addAction($0)}
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func deleteFlashCard(_ flashCard: FlashCardModel){
        guard let index = newsCardsDidSet.firstIndex(of: flashCard) else {
            return
        }
        
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            
            showAlert(title: "There is an error when deleting", message: "Error: \(error)")
        }
    }
}

extension FlashCardsController: DataPersistenceDelegate{
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
}
