//
//  CardListViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 20.11.24.
//
import Foundation
import RealmSwift

final class TransferViewModel {
    enum ViewState {
        case error(message:String)
        case succsess
    }
    var callback:((ViewState)->Void)?
    private(set) var cards: Results<Card>?
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
    
    func checkValidation() {
        guard selectedCardFrom != selectedCardTo else {return showError(message: "Eyni kart secile bilmez")}
        guard selectedCardFrom.balance != 0 else {return showError(message: "Kartin balansi bosdur")}
        guard amount < selectedCardFrom.balance else {return showError(message: "Balansda kifayet qeder vesait yoxdur")}
        guard amount >= 1 else {return showError(message: "Mebleg minimum 1 azn olmalidir")}
       
        transfer()
        callback?(.succsess)
    }
    
    func showError(message:String) {
        callback?(.error(message: message))
    }
}
