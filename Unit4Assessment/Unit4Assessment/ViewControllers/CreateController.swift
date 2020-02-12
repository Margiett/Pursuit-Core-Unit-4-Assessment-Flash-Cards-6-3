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
    var flashCard: FlashCardModel!
    
    //      lazy var titleTF = create.createText
    //      lazy var quizFact1 = create.createTextFieldOne
    //      lazy var quizFact2 = create.secondQuizFact
    
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView.createTextFieldOne.delegate = self
       // createView.createText.delegate = self
        createView.secondQuizFact.delegate = self
        addBarButtonItems()
        view.backgroundColor = .systemPink
        
    }
    
    
    
    private func addBarButtonItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(createButtonPressed))
    }
    @objc
    private func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
        
    }
    
    @objc
    private func createButtonPressed(_ sender: UIBarButtonItem){
        guard let titleOfQuiz = createView.createText.text, !titleOfQuiz.isEmpty, let factOne = createView.createTextFieldOne.text, !factOne.isEmpty, let secondFact = createView.secondQuizFact.text, !secondFact.isEmpty else {
            showAlert(title: "Please input a Quiz title, and 2 facts", message: "Please make sure you have a title Quiz and two facts")
            return
        }
        showAlert(title: "Done", message: "Your new Quiz card has been created")
        flashCard = FlashCardModel(quizTitle: titleOfQuiz, facts: [factOne, secondFact])
        
        if dp.hasItemBeenSaved(flashCard) {
            showAlert(title: "Duplicate Flashcard", message: "No Duplicate Allowed")
        } else {
            do {
                try dp.createItem(flashCard)
                showAlert(title: "QuizFact is Saving .. ", message: "Quiz Fact was Successfully saved")
            } catch {
                showAlert(title: "Error Saving", message: "Save failed")
            }
        }
    }
}
extension CreateController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter flashcard fact" && textView.textColor == UIColor.lightGray {
            createView.createText.text = ""
            createView.createTextFieldOne.text = ""
            createView.secondQuizFact.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" && textView.textColor == UIColor.black {
            textView.text = "Enter flashcard fact"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    
}



