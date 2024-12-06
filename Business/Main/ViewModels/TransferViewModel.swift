//
//  CardListViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 20.11.24.
//


import Foundation

final class TransferViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(message:String)
        case succsess
    }
    var callback:((ViewState)->Void)?
    private(set) var cards = RealmHelper.instance.getList(of: Card.self)
    var selectedCardFrom = Card()
    var selectedCardTo = Card()
    var amount = Int()
    
    func getList() {
        cards =  RealmHelper.instance.getList(of: Card.self)
    }
    func transfer() {
        RealmHelper.instance.updateObject {
            selectedCardFrom.balance -= amount
            selectedCardTo.balance += amount
        }
    }
    
    func checkValidation() -> Bool {
        guard selectedCardFrom != selectedCardTo else {showError(message: "Eyni kart secile bilmez")
            return false }
        guard selectedCardFrom.balance != 0 else { showError(message: "Kartin balansi bosdur")
            return false }
        guard amount <= selectedCardFrom.balance else {showError(message: "Balansda kifayet qeder vesait yoxdur")
            return false }
        guard amount >= 1 else { showError(message: "Mebleg minimum 1 azn olmalidir")
            return false}
       
        transfer()
        callback?(.succsess)
        return true
        
    }
    
    func showError(message:String) {
        callback?(.error(message: message))
    }
}
