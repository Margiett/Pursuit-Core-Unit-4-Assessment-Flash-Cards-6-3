//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
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
        label.text = "second question"
        return label
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
       let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(cellWasTapped))
        return gesture
    }()
    
    private var isBackOfCardShowing = false
    
    @objc private func cellWasTapped(_ gesture: UITapGestureRecognizer){
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
