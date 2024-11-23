//
//  CardModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//
import Foundation
import RealmSwift
enum CardType: String, PersistableEnum {
    case visa = "Visa"
    case master = "MasterCard"
}
class Card: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var pan: String?
    @Persisted var date: String?
    @Persisted var cvv: String?
    @Persisted var balance: Int = 10
    @Persisted var cardType: CardType?
}

