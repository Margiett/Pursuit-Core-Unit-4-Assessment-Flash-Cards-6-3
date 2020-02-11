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

  public var createVar: DataPersistence<FlashCardModel>!
     private let create = CreateView()
    
      lazy var titleTF = create.createText
      lazy var quizFact1 = create.createTextFieldOne
      lazy var quizFact2 = create.secondQuizFact


        var dataPersistence:DataPersistence<FlashCardModel>!
        
        var flashCard: FlashCardModel!
        
        override func loadView() {
            view = create
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            delegatesAndDataSources()
            addBarButtonItems()
        }
        
        private func delegatesAndDataSources(){
            create.createTextFieldOne.delegate = self
            create.secondQuizFact.delegate = self
        }
        
        private func addBarButtonItems(){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(createButtonPressed))
        }
        
        @objc
        private func createButtonPressed(_ sender: UIBarButtonItem){
            guard let titleOfQuiz = titleTF.text else {
        
                print("Quiz Requires a title")
                showAlert(title: "Quiz Requires title", message: "No Title was entered")
                return
            }
             
            
            guard let factNum1 = quizFact1.text else {
                showAlert(title: "Quiz Requires a Fact", message: "Fact 1 out of two was not entered")
                return
            }
            
            guard let factNum2 = quizFact2.text else {
               showAlert(title: "Quiz Requires two facts", message: "Must enter two facts")
                return
            }
            
           // flashCard = FlashCardModel(id: "", quizTitle: titleTF.description, facts: [quizFact1, quizFact2])
            
            if dataPersistence.hasItemBeenSaved(flashCard){
            showAlert(title: "Dupicated Flashcards", message: "Create a unique flash card")
            } else {
                do {
                    
                    try dataPersistence.createItem(flashCard)
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
 


