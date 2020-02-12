//
//  SearchController.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchController: UIViewController {
    
     public var dp: DataPersistence<FlashCardModel>!
    
    let flashCardVC = FlashCardsController()
    
    private var searchView = SearchView()
    
    private var selectedCard: FlashCardModel?
    
    let mainVC = FlashCardsController()
    
    private var searchingForFlashCards = [FlashCardModel]()
   
    
    private var flashCardsDidSetSearch = [FlashCardModel]() {
        didSet{
            DispatchQueue.main.async {
                self.searchView.collectionV.reloadData()
            }
            if flashCardsDidSetSearch.isEmpty {
                searchView.collectionV.backgroundView = EmptyView(title: "Flash Cards", message: "No Flash Card were found")
            } else {
                DispatchQueue.main.async {
                    self.searchView.collectionV.backgroundView = nil
                }
            }
        }
    }
    
    
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.collectionV.dataSource = self
        searchView.collectionV.delegate = self
        searchView.collectionV.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        view.backgroundColor = .purple
        
        
            do {
                flashCardsDidSetSearch = try FlashCardService.getData()
                
            } catch {
                showAlert(title: "issues loading", message: "Error \(error)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchCards()
    }
    
    private func fetchCards(){
        do {
            flashCardsDidSetSearch = try dp.loadItems()
        } catch {
            showAlert(title: "Issue Loading", message: "Error \(error)")
            
        }
        
    }
}

extension SearchController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("It was saved")
        fetchCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchCards()
    }
    
    
    
    
}



extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // this is where you return the actual size of the cell.
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        // MARK: this is to change the height of the cell
        let itemHeight: CGFloat = maxSize.height * 0.15 // make it 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theCard = flashCardsDidSetSearch[indexPath.row]
        
        selectedCard = theCard
        flashCardVC.saveCardsDidSet.append(selectedCard!)
        
    }
}

extension SearchController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCardsDidSetSearch.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("couldnt downcast ")
        }
        
        
        let selectedCard = flashCardsDidSetSearch[indexPath.row]
        
        cell.delegate = self
        cell.backgroundColor = .white
        
        cell.configureCell(for: selectedCard)
        return cell
    }
}

extension SearchController: SearchCellDelegate {
    func didSelectAddButton(_ searchCell: SearchCell, aSearchCard: FlashCardModel) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        let addAction = UIAlertAction(title:"Add", style: .default) {
            alertAction in
            
            
            DispatchQueue.main.async {
                self.showAlert(title: "Card was added", message: "Your, card was added")
                self.flashCardTransfer(aSearchCard)
                
                
                
            }
            
            self.tabBarController?.selectedIndex = 0
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    private func flashCardTransfer(_ searchCard: FlashCardModel){
        do{
            
            try  dp.createItem(searchCard)
            
        }catch{
            print("error deleting \(error)")
        }
    }
    
}


