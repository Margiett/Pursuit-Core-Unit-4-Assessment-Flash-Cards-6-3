//
//  SearchView.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchView: UIView {
    //lazy var only get created when it gets called. like a reference
    
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        
        sb.autocapitalizationType = .none
        sb.placeholder = "search for card"
        sb.backgroundColor = .red
        
        return sb
        
    }() // this is a closure . 
    
     
    public lazy var collectionV: UICollectionView = {
        // create layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .gray
        return cv
    }()
    
    
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            setUpSBContraints()
            setUpCollectionView()
        }
        
    private func setUpSBContraints(){
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false // this will allow for the auto layout infomation to be added instead of the main one
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpCollectionView(){
        addSubview(collectionV)
        
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
             collectionV.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                      collectionV.leadingAnchor.constraint(equalTo: leadingAnchor),
                      collectionV.trailingAnchor.constraint(equalTo: trailingAnchor),
                      collectionV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

  

}
