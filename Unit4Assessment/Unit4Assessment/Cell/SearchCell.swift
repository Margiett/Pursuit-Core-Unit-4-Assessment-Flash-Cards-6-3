//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
protocol SearchCellDelegate: AnyObject {
    func didSelectAddButton(_ searchCellPro: SearchCell, aSearchCard: FlashCardModel)
}

class SearchCell: UICollectionViewCell {
    
    public weak var delegate: SearchCellDelegate?
    
    private var currentCard: FlashCardModel!
    
       public lazy var addButton: UIButton = {
            let button = UIButton()
              button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            
              button.addTarget(self, action: #selector(AddButtonPressed(_:)), for: .touchUpInside)
           
              return button
          }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "first question"
        return label
    }()
    
    private lazy var quizFactLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Facts"
        return label
    }()
    
    public func configureCell(for searchCard: FlashCardModel) {
        currentCard = searchCard
        titleLabel.text = searchCard.quizTitle
        quizFactLabel.text = searchCard.facts.joined(separator: ", ")
        
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpButtonConstraints()
        setupTitleLabelConstrainsts()
        setupFactsLabelConstrainsts()
        titleLabel.isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func AddButtonPressed(_ sender: UIButton){
      // this is the button itself
      print("button was pressed \(currentCard.quizTitle)")
      delegate?.didSelectAddButton(self, aSearchCard: currentCard)
      
    }
    
    //MARK: Setting up the constraints !!
    
    private func setUpButtonConstraints(){
           addSubview(addButton)
           
           addButton.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               addButton.topAnchor.constraint(equalTo: topAnchor),
               addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
               addButton.heightAnchor.constraint(equalToConstant: 44)
              
               ,
               addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
           
           ])
       }
    
    private func setupTitleLabelConstrainsts(){
           addSubview(titleLabel)
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
               titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
               titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
           
           ])
       }
       
       private func setupFactsLabelConstrainsts() {
          addSubview(quizFactLabel)
           
           quizFactLabel.translatesAutoresizingMaskIntoConstraints = false
        
           NSLayoutConstraint.activate([
               quizFactLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
               quizFactLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               quizFactLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant:  8),
               quizFactLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
           ])
       }
    

       
    //MARK: Gesture !
    lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(cellWasTapped))
        return gesture
    }()
    
    private var isBackOfCardShowing = false
    
    @objc
    private func cellWasTapped(_ gesture: UITapGestureRecognizer){
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isBackOfCardShowing.toggle()
        animate()
    }
    
    private func animate(){
        let duration = 1.0
        
        if isBackOfCardShowing {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.quizFactLabel.alpha = 1
                self.titleLabel.alpha = 0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.quizFactLabel.alpha = 0
                self.titleLabel.alpha = 1
            }, completion: nil)
        }
    }
    
    
    
    
    
}

