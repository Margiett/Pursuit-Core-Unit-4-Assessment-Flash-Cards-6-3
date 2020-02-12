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
    // setting the delegate
    weak var delegate: SearchCellDelegate?
    
    private var currentCard: FlashCardModel!
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture  = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    // MARK: this is the button...
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        button.addTarget(self, action: #selector(AddButtonPressed(_:)), for: .touchUpInside)
        
        return button
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemPink
        return label
    }()
    
    public lazy var quizFact1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .blue
        // need to set the aplha of one in order for it to toggle properly
        label.alpha = 0
        return label
    }()
    
    public lazy var quizFact2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .orange
        label.alpha = 0
        return label
    }()
    
    public func configureCell(for addedCard: FlashCardModel){
        currentCard = addedCard // associating the cell with its article
        // need to set the article or it will be nil and it will crash
        titleLabel.text = addedCard.quizTitle
        quizFact1.text = addedCard.facts.first
        quizFact2.text = addedCard.facts.last
        
    }
    
    private var isCurrentCardTitleShowing = true
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpButtonConstraints()
        setupTitleLabel()
        setupQuizLabel()
        setupQuizFactLabel2()
        titleLabel.isUserInteractionEnabled = true
        addGestureRecognizer(longPressGesture)
        
    }
    
    @objc
    private func AddButtonPressed(_ sender: UIButton){
        // this is the button itself
        print("button was pressed for article \(currentCard.quizTitle)")
        delegate?.didSelectAddButton(self, aSearchCard: currentCard)
        
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer){
        print("outside gesture")
        guard currentCard != nil else { return }
        
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        isCurrentCardTitleShowing.toggle() // true -> false
        animate()
        
    }
    
    // to make it turn..
    private func animate() {
        let duration: Double = 1.0
        if isCurrentCardTitleShowing {
            // self is the sell
            UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                // this closure is not a network request does not need weak self no network call
                self.titleLabel.alpha = 1.0
                self.quizFact1.alpha = 0.0
                self.quizFact2.alpha = 0.0
                
            }, completion: nil )
        } else {
            UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                // this closure is not a network request does not need weak self no network call
                self.titleLabel.alpha = 0.0
                self.quizFact1.alpha = 1.0
                self.quizFact2.alpha = 1.0
            }, completion: nil )
            
        }
    }// the end of the animate function
    
    //MARK: Seting up Constraints !!
    private func setUpButtonConstraints(){
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
            
        ])
    }
    
    private func setupTitleLabel(){
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    private func setupQuizFactLabel2() {
        addSubview(quizFact2)
        quizFact2.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            quizFact2.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            quizFact2.leadingAnchor.constraint(equalTo: leadingAnchor),
            quizFact2.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant:  8),
            quizFact2.bottomAnchor.constraint(equalTo: quizFact1.topAnchor, constant: -8)
        ])
    }
    
    private func setupQuizLabel() {
        addSubview(quizFact1)
        
        quizFact1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizFact1.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            quizFact1.leadingAnchor.constraint(equalTo: leadingAnchor ),
            quizFact1.trailingAnchor.constraint(equalTo: trailingAnchor ),
            quizFact1.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
}







