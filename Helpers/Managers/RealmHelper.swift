//
//  RealmHelper.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 04.11.24.
//
import RealmSwift
import UIKit
class RealmHelper {
    private init() { }
        static let instance = RealmHelper()
    let realm = try! Realm()
}
