//
//  UserModel.swift
//  UserRegister
//
//  Created by Bakhtiyar Pirizada on 01.11.24.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String?
    @Persisted var surname: String?
    @Persisted var email: String?
    @Persisted var password: String?
}

