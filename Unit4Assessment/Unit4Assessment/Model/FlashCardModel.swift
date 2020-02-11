//
//  FlashCardModel.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

//struct FlashCardData: Codable & Equatable {
//    let cards: [FlashCard]
//}
//
//struct FlashCard: Codable & Equatable {
//    let cardTitle: String
//    let facts: [String]
//}

struct FlashCardModel: Codable & Equatable {
    let id: String
    let quizTitle: String
    let facts: [String]
}
