//
//  JSONData.swift
//  Unit4Assessment
//
//  Created by Margiett Gil on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

class FlashCardService {
  public static func fetchCards() throws -> [FlashCardModel] {
    guard let path = Bundle.main.path(forResource: "cards", ofType: "json") else {
      throw ServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw ServiceError.contentsNotFound
    }
    do {
      let cards = try JSONDecoder().decode([FlashCardModel].self, from: json)
        return cards
    } catch {
      throw ServiceError.decodingError(error)
    }
  }
}


//public enum AppleServiceError: Error {
//  case resourcePathDoesNotExist
//  case contentsNotFound
//  case decodingError(Error)
//}
//
//final class AppleStockService {
//  public static func fetchStocks() throws -> [StockPrice] {
//    guard let path = Bundle.main.path(forResource: "appleStockInfo", ofType: "json") else {
//      throw AppleServiceError.resourcePathDoesNotExist
//    }
//    guard let json = FileManager.default.contents(atPath: path) else {
//      throw AppleServiceError.contentsNotFound
//    }
//    do {
//      let stocks = try JSONDecoder().decode([StockPrice].self, from: json)
//      return stocks
//    } catch {
//      throw AppleServiceError.decodingError(error)
//    }
//  }
//}
