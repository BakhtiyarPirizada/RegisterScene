//
//  AuthViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 09.11.24.
//

import Foundation

final class AuthViewModel {
    
    enum ViewState {
        case errorToRegister(message:String)
        case errorToLogin(message:String)
        case success
        case loading
        case loaded
    }
    var callback:((ViewState)->Void)?
    
    private var users = RealmHelper.instance.getList(of: User.self)
    
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
        return users.contains {$0.email == logEmail && $0.password == logPassword}
    }
    
    func loginValidations() -> Bool {
        guard !logEmail.isEmpty && !logPassword.isEmpty else { showErrorLogin(message: "Fields cannot be emtpy")
            return false }
        guard checkUser() else {showErrorLogin(message: "User is not found!"); UserDefaultsHelper.setBool(key: "isLogin", value: false)
            return false }
        UserDefaultsHelper.setBool(key: "isLogin", value: true)
        return true

    }
    
    func checkValidation() -> Bool {
        guard !username.isEmpty,!surname.isEmpty,!number.isEmpty,!email.isEmpty , !password.isEmpty
        else { showErrorRegister(message: "Fields cannot be emtpy")
            return false}
        guard username.isValidName() else {showErrorRegister(message: "Username must be minimum 3 characters")
            return false}
        guard surname.isValidLastname() else {showErrorRegister(message: "Surname must be minimum 5 characters")
            return false}
        guard number.isValidPhoneNumber() else {showErrorRegister(message: "Phone number must be 994 format")
            return false}
        guard email.isValidEmail() else { showErrorRegister(message: "Email must be email format")
            return false}
        guard password.isValidPass() else { showErrorRegister(message: "Password must be minimum 8 characters")
            return false}
        createUser()
        return true
    }
    
    func showErrorRegister(message:String) {
        callback?(.errorToRegister(message: message))
    }
    
    func showErrorLogin(message:String) {
        callback?(.errorToLogin(message: message))
    }
    
    func getList() {
        users = RealmHelper.instance.getList(of: User.self)
    }
   
    func writeRealm(model:User) {
        RealmHelper.instance.addObject(model)
    }
    
}
