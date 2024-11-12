//
//  AuthViewModel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 09.11.24.
//
protocol AuthSenderDelegate: AnyObject {
    func errorMessage(error: String)
    func defaultUserDelegate(user:User)
}
import RealmSwift
import Foundation

class AuthViewModel {
    
    private var Users: Results<User>?
    private let realm = try! Realm()
    weak var delegate : (AuthSenderDelegate)?
    lazy var username = ""
    lazy var surname = ""
    lazy var email = ""
    lazy var password = ""
    lazy var number = ""
    lazy var logEmail = ""
    lazy var logPassword = ""
    
    open func createUser() {
        let user = User()
        user.name = username
        user.surname = surname
        user.email = email
        user.password = password
        writeRealm(model: user)
        getList()
        delegate?.defaultUserDelegate(user: user)
    }
    
    open func checkUser() -> Bool{
        var result = false
        getList()
        guard let users = Users else {return false}
        for user in users {
            if user.email == logEmail && user.password == logPassword {
                result = true
            }
        }
        return result
    }

    open func checkValidation() {
        if !username.isEmpty || !surname.isEmpty || !number.isEmpty || !email.isEmpty || !password.isEmpty {
            if username.isValidName(){
                if surname.isValidLastname() {
                    if number.isValidPhoneNumber(){
                        if email.isValidEmail() {
                            if password.isValidPass() {
                                createUser()
                            }else { delegate?.errorMessage(error: "Password must be minimum 8 characters")}
                        }else {delegate?.errorMessage(error: "Email must be email format")}
                    }else {delegate?.errorMessage(error: "Phone number must be 994 format ")}
                }else{delegate?.errorMessage(error: "Surname must be minimum 5 characters")}
            }else {delegate?.errorMessage(error: "Username must be minimum 3 characters")}
        }else{ delegate?.errorMessage(error: "Fields cannot be emtpy")}
    }
   
    open func getList() {
        let results = realm.objects(User.self)
        Users = results
    }
    
    open func writeRealm(model:Object) {
        try! realm.write {
            realm.add(model)
        }
    }
   
}
