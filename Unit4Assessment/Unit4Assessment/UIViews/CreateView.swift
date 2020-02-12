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
        textV.autocorrectionType = .yes
        textV.placeholder = "Enter quiz title"
        textV.textAlignment = .center
        textV.backgroundColor = .gray
        return textV
    }()
    
    public lazy var createTextFieldOne: UITextView = {
        
        let one = UITextView()
        one.autocapitalizationType = .none
        one.autocorrectionType = .yes
        one.textAlignment = .center
        one.text = "Enter First Quiz Fact"
        one.backgroundColor = .gray
        return one
    }()
    
    public lazy var secondQuizFact: UITextView = {
        let second = UITextView()
        second.autocapitalizationType = .none
        second.autocorrectionType = .yes
        second.textAlignment = .center
        second.text = "Enter Second Quiz fact"
        second.backgroundColor = .gray
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
          createText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            createText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            createText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            createText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
        ])
    }
    private func setupCreateTextFieldOne() {
        addSubview(createTextFieldOne)
        createTextFieldOne.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createTextFieldOne.topAnchor.constraint(equalTo: createText.bottomAnchor, constant: 8),
            createTextFieldOne.leadingAnchor.constraint(equalTo: createText.leadingAnchor),
            createTextFieldOne.trailingAnchor.constraint(equalTo: createText.trailingAnchor),
            createTextFieldOne.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)

        ])
    }
    private func setupSecondQuizFact() {
        addSubview(secondQuizFact)
        secondQuizFact.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            secondQuizFact.centerYAnchor.constraint(equalTo: createTextFieldOne.bottomAnchor, constant: self.frame.height * 0.15),
                secondQuizFact.heightAnchor.constraint(equalTo: createTextFieldOne.heightAnchor),
                secondQuizFact.widthAnchor.constraint(equalTo: createTextFieldOne.widthAnchor, multiplier: 1),
                secondQuizFact.centerXAnchor.constraint(equalTo: createTextFieldOne.centerXAnchor)

        
        ])
    }
    

}
