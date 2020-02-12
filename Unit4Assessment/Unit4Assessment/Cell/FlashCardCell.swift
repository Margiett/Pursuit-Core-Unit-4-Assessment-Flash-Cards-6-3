//
//  FlashCardCell.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol FlashCardButtonDelegate: AnyObject {
    func moreButtonPressed(_ collectionViewCell: FlashCardCell, flashCard: FlashCardModel)
    //func didSelectAddButton(_ searchCellPro: SearchCell, aSearchCard: FlashCardModel)
    
}

class FlashCardCell: UICollectionViewCell {
    var existingFlashCard: FlashCardModel!
    
    weak var delegate: FlashCardButtonDelegate!
    
    
    lazy var longpressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_ :)))
        return gesture
    }()
    
    lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return editButton
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = .systemGray
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var factLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = .systemGray
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var factLabelTwo :UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = .systemGray
        label.isUserInteractionEnabled = true
        return label
    }()
 
    
     private var isBackOfCardShowing = false
    
    override init(frame: CGRect) {
           super.init(frame: UIScreen.main.bounds)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
       
       private func commonInit(){
           setupEditButtonConstrainsts()
           setupTitleLabelConstrainsts()
           setupFactsLabelConstrainsts()
        setupFactLabelTwo()
           addGestureRecognizer(longpressGesture)
       }
  
    
    @objc
    public func editButtonPressed(){
        delegate.moreButtonPressed(self, flashCard: existingFlashCard)
    }
    
    @objc
    private func didLongPress(_ gesture: UILongPressGestureRecognizer){
        guard existingFlashCard != nil else { return }
        if gesture.state == .began || gesture.state == .changed {
            print("testing is working ")
            return
        }
        isBackOfCardShowing.toggle()
        animate()
    }
    //MARK: This is what makes the card turn why is not working !!!!!!!!
    private func animate(){
        let duration = 1.0
        
        if isBackOfCardShowing {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.factLabel.alpha = 0.0
                self.factLabelTwo.alpha = 0.0
                self.titleLabel.alpha = 1
            }, completion: nil)
        }else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                
                self.titleLabel.alpha = 0.0
                self.factLabel.alpha = 1.0
                self.factLabelTwo.alpha = 1.0
            }, completion: nil)
        }
    }
    
    public func configureCell(for card: FlashCardModel){
        existingFlashCard = card
        titleLabel.text = card.quizTitle
        factLabel.text = card.facts.first
        factLabelTwo.text = card.facts.last
    }
    
   
    
    //MARK: Constraints !
    
    private func setupEditButtonConstrainsts(){
        addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            editButton.widthAnchor.constraint(equalTo: editButton.heightAnchor)
        ])
    }
    
    private func setupTitleLabelConstrainsts(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupFactsLabelConstrainsts(){
        addSubview(factLabel)
        factLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            factLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            factLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            factLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func setupFactLabelTwo(){
        addSubview(factLabelTwo)
        
        factLabelTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            factLabelTwo.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            factLabelTwo.leadingAnchor.constraint(equalTo: leadingAnchor),
            factLabelTwo.trailingAnchor.constraint(equalTo: trailingAnchor),
            factLabelTwo.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
}
