//
//  AuthViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 09.11.24.
//

import RealmSwift
import Foundation

final class AuthViewModel {
    
    enum ViewState {
        case error(message:String)
    }
    var callback:((ViewState)->Void)?
    private var Users: Results<User>?
    private let realm = try! Realm()
    lazy var username = ""
    lazy var surname = ""
    lazy var email = ""
    lazy var password = ""
    lazy var number = ""
    lazy var logEmail = ""
    lazy var logPassword = ""
    
    func createUser() {
        let user = User()
        user.name = username
        user.surname = surname
        user.email = email
        user.password = password
        writeRealm(model: user)
        getList()
  
    }
    
    func checkUser() -> Bool {
        getList()
        guard let users = Users else {return false}
        return users.contains {$0.email == logEmail && $0.password == logPassword}
    }
    
    func checkValidation() {
        guard !username.isEmpty,!surname.isEmpty,!number.isEmpty,!email.isEmpty , !password.isEmpty
        else {return showError(message: "Fields cannot be emtpy")}
        guard username.isValidName() else {return showError(message: "Username must be minimum 3 characters")}
        guard surname.isValidLastname() else {return showError(message: "Surname must be minimum 5 characters")}
        guard number.isValidPhoneNumber() else {return showError(message: "Phone number must be 994 format")}
        guard email.isValidEmail() else {return showError(message: "Email must be email format")}
        guard password.isValidPass() else {return showError(message: "Password must be minimum 8 characters")}
        createUser()
        
    }
    
    func showError(message:String) {
        callback?(.error(message: message))
    }
    
    func getList() {
        let results = realm.objects(User.self)
        Users = results
    }
    
    func writeRealm(model:Object) {
        try! realm.write {
            realm.add(model)
        }
    }
    
}
