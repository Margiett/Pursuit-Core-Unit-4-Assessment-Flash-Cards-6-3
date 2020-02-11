//
//  CardsView.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardsView: UIView {
    
    // made the collectionView
    public lazy var collectionV: UICollectionView = {
        // create layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .systemGroupedBackground
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
        setUpCollectionView()
    }
    private func setUpCollectionView(){
        addSubview(collectionV)
        
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionV.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionV.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
