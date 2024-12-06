//
//  CardModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//
import Foundation
import RealmSwift

enum CardType: String, PersistableEnum {
    case visa
    case master
    var imageName: String {
        switch self {
        case .visa:
            return "Visa"
        case .master:
            return "MasterCard"
        }
    }
}
class Card: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var pan: String?
    @Persisted var date: String?
    @Persisted var cvv: String?
    @Persisted var balance: Int = 10
    @Persisted var cardType: CardType?
}

