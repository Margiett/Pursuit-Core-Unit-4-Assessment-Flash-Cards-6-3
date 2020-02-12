//
//  CreateController.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateController: UIViewController {
    var dp:DataPersistence<FlashCardModel>!
    //public var createVar: DataPersistence<FlashCardModel>!
    private let createView = CreateView()
    var flashCard: FlashCardModel?
    
    //      lazy var titleTF = create.createText
    //      lazy var quizFact1 = create.createTextFieldOne
    //      lazy var quizFact2 = create.secondQuizFact
    
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        createView.createTextFieldOne.delegate = self
        createView.createText.delegate = self
        createView.secondQuizFact.delegate = self
        addBarButtonItems()
        view.backgroundColor = .systemPink
        
    }
    
    
    
    private func addBarButtonItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(createButtonPressed))
    }
    //    @objc
    //    private func dismissKeyboard(_ sender: UITapGestureRecognizer){
    //        view.endEditing(true)
    //
    //    }
    
    @objc
     private func createButtonPressed(_ sender: UIBarButtonItem){
        guard let titleOfQuiz = createView.createText.text, !titleOfQuiz.isEmpty, let factOne = createView.createTextFieldOne.text, !factOne.isEmpty, let secondFact = createView.secondQuizFact.text, !secondFact.isEmpty else {
            showAlert(title: "Please input a Quiz title, and 2 facts", message: "Please make sure you have a title Quiz and two facts")
            return
        }
        showAlert(title: "Done", message: "Your new Quiz card has been created")
        flashCard = FlashCardModel(quizTitle: titleOfQuiz, facts: [factOne, secondFact])
        
        
        if dp.hasItemBeenSaved(FlashCardModel){
            showAlert(title: "Dupicated Flashcards", message: "Create a unique flash card")
        } else {
            do {
                try dp.createItem(FlashCardModel)
                showAlert(title: "Your Fun Fact is being saved", message: " It was successfully saved")
            } catch {
                showAlert(title: "Your quiz fact is being saved", message: "failed to save try again")
            }
        }
    }
    
}

extension CreateController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter flashcard fact" && textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" && textView.textColor == UIColor.black {
            textView.text = "Enter flashcard fact"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    
}



