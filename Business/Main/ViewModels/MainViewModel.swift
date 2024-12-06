//
//  MainViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//
import Foundation

final class MainViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(message:String)
        case success
    }
    
    var cards = RealmHelper.instance.getList(of: Card.self)
    
  
    fileprivate var isVisa = Bool.random()
    var callback:((ViewState)->Void)?
    
    
    func getList() {
        let results = RealmHelper.instance.realm.objects(Card.self)
        cards = results
    }
    
    func writeRealm(model:Card) {
        RealmHelper.instance.addObject(model)
    }
    func deleteRealm(index: Int) {
        guard cards.count > 1 else { return showMessage(message: "Minimum 1 debit kart olmalidir")}
        RealmHelper.instance.deleteObject(cards[index])
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
        callback?(.success)
    }
}
