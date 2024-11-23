//
//  MainViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//
import Foundation
import RealmSwift

final class MainViewModel {
    enum ViewState {
        case error(message:String)
    }
    
    var cards: Results<Card>?
    private let realm = try! Realm()
    fileprivate var isVisa = Bool.random()
    var callback:((ViewState)->Void)?
    
    
    func getList() {
        let results = realm.objects(Card.self)
        cards = results
    }
    
    func writeRealm(model:Object) {
        try! realm.write {
            realm.add(model)
        }
    }
    func deleteRealm(index: Int) {
        guard cards?.count ?? 0 > 1 else { return showMessage(message: "Minimum 1 debit kart olmalidir")}
        guard let card = cards?[index] else {return}
        try! realm.write {
            realm.delete(card)
        }
    }
    func showMessage(message: String) {
        callback?(.error(message: message))
    }
    
    func createCard() {
        let card = Card()
        let randomPan = String.generateRandomCardNumber(isVisa: isVisa)
        let expirationDate = String.generateCardExpiryDate()
        let cVV = String.generateRandomCVV()
        let balance = 10
        card.pan = randomPan
        card.date = expirationDate
        card.cvv = cVV
        card.balance = balance
        if isVisa == true {
            card.cardType = .visa
        } else {
            card.cardType = .master
        }
        writeRealm(model: card)
        getList()
        isVisa = Bool.random()
    }
}
