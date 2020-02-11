//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {

    public lazy var createText: UITextField = {
        let textV = UITextField()
        textV.autocapitalizationType = .none
        textV.placeholder = "Enter quiz title"
        return textV
    }()
    
    public lazy var createTextFieldOne: UITextField = {
        
        let one = UITextField()
        one.autocapitalizationType = .none
        one.placeholder = "Enter First Quiz Fact"
        return one
    }()
    
    public lazy var secondQuizFact: UITextField = {
        let second = UITextField()
        second.autocapitalizationType = .none
        second.placeholder = "Enter Second Quiz fact"
        return second
        
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
        setupCreateText()
        setupCreateTextFieldOne()
        setupSecondQuizFact()
    }
    private func setupCreateText() {
        addSubview(createText)
        createText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            createText.leadingAnchor.constraint(equalTo: leadingAnchor),
            createText.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func setupCreateTextFieldOne() {
        addSubview(createTextFieldOne)
        createTextFieldOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createTextFieldOne.topAnchor.constraint(equalTo: createText.bottomAnchor, constant: 8),
            createTextFieldOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            createTextFieldOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func setupSecondQuizFact() {
        addSubview(secondQuizFact)
        secondQuizFact.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            secondQuizFact.topAnchor.constraint(equalTo: createTextFieldOne.bottomAnchor, constant: 8),
            secondQuizFact.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            secondQuizFact.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    

}
