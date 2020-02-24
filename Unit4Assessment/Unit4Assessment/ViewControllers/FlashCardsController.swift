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
    
    public var saveCardsDidSet = [FlashCardModel]() {
        didSet{
            self.flashCardView.collectionView.reloadData()
            if saveCardsDidSet.isEmpty {
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
        flashCardView.collectionView.dataSource = self
        flashCardView.collectionView.delegate = self
        
        
flashCardView.collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "FlashCardCell")
        view.backgroundColor = .cyan
        fetchCards()
        
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCards()
    }
    
    private func fetchCards() {
        do {
            saveCardsDidSet = try dataPersistence.loadItems()
        } catch {
            showAlert(title: "there was an loading error", message: "Error: \(error)")
        }
    }
    

}

//MARK: Delegate !
extension FlashCardsController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // this is where you return the actual size of the cell
        let maxSize:CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 8
        let numberOfItems:CGFloat = 1
        //this is to change the height of the cell
        let itemHeight:CGFloat = maxSize.height * 0.3
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }

  
}
//MARK: DataSource !
extension FlashCardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveCardsDidSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlashCardCell", for: indexPath) as? FlashCardCell else{
            fatalError("failed to downcast")
        }
        
        let selectedFlashCard = saveCardsDidSet[indexPath.row]
        cell.configureCell(for: selectedFlashCard)
        cell.delegate = self
        cell.backgroundColor = .gray
        
        return cell
    }
    
    
}



extension FlashCardsController: FlashCardButtonDelegate{
    func moreButtonPressed(_ collectionViewCell: FlashCardCell, flashCard: FlashCardModel) {
        let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete \(flashCard.quizTitle)?", style: .destructive) { (alertAction) in self.deleteFlashCard(flashCard)
            self.fetchCards()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action2 = [deleteAction, cancelAction]
        action2.forEach{ action.addAction($0)}
        present(action, animated:  true, completion:  nil)
    }
    
    func didSelectCreateButton(_ collectionViewCell: FlashCardCell, flashCard: FlashCardModel) {
        let actionSheet = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete \(flashCard.quizTitle)?", style: .destructive) { (alertAction) in
            self.deleteFlashCard(flashCard)
            self.flashCardView.collectionView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actions = [deleteAction, cancelAction]
        actions.forEach { actionSheet.addAction($0)}
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func deleteFlashCard(_ flashCard: FlashCardModel){
        guard let index = saveCardsDidSet.firstIndex(of: flashCard) else {
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
        fetchCards()
        
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchCards()

    }

}
