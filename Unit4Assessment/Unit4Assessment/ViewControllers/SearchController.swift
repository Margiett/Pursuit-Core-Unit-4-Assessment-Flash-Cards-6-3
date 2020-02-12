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
    
  private var searchView = SearchView()
    
    var dataPersistence: DataPersistence<FlashCardModel>!
        
    private var selectedCard: FlashCardModel?
        
        private var flashCardsDidSetSearch = [FlashCardModel]() {
            didSet{
                DispatchQueue.main.async {
                    self.searchView.collectionV.reloadData()
                }
            }
        }
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        searchView.collectionV.dataSource = self
        searchView.collectionV.delegate = self
        searchView.collectionV.register(SearchView.self, forCellWithReuseIdentifier: "searchCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fectchCards()
    }
    private func fectchCards() {
        do {
            flashCardsDidSetSearch = try dataPersistence.loadItems()
        } catch {
            showAlert(title: "Issue Loading", message: "Error \(error)")
            
        }
        
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.15
      
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = flashCardsDidSetSearch[indexPath.row]
        
    selectedCard = card
        
        
    }
}

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCardsDidSetSearch.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else{
        fatalError("failed to downcast")
        }
        let selectedCard = flashCardsDidSetSearch[indexPath.row]
        //cell.delegate = self
        cell.backgroundColor = .lightGray
        
        cell.configureCell(for: selectedCard)
        return cell
    }
}

