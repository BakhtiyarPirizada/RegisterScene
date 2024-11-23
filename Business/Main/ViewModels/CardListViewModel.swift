//
//  CardListViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 20.11.24.
//
import Foundation
import RealmSwift

final class CardListViewModel {
    
    private(set) var cards: Results<Card>?
    private(set) var selectedCardFrom = Card()
    private(set) var selectedCardTo = Card()
    
    
    func getList() {
        cards =  RealmHelper.instance.getList(of: Card.self)
    }
    func update() {
        
    }
}
