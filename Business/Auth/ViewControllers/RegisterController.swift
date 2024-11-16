//
//  RegisterController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 02.11.24.
//

import UIKit
import RealmSwift
class RegisterController: BaseViewController {
    
    private var viewModel = AuthViewModel()
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: ReusableLabel{
        let l = ReusableLabel(title: "Create Account", size: 36)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }
    
    private lazy var nameText: ReusableText = {
        let t = ReusableText(title:"Name")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var surnameText: ReusableText = {
        let t = ReusableText(title:"Surname")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var numberText:ReusableText = {
        let t = ReusableText(title:"Phone number")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var emailText: ReusableText = {
        let t = ReusableText(title:"Valid email")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var passwordContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 12
        container.addSubview(passwordText)
        container.addSubview(eyeButton)
        
        NSLayoutConstraint.activate([
            passwordText.topAnchor.constraint(equalTo: container.topAnchor),
            passwordText.leftAnchor.constraint(equalTo: container.leftAnchor),
            passwordText.rightAnchor.constraint(equalTo: container.rightAnchor),
            passwordText.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            eyeButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            eyeButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        return container
    }()
    
    private lazy var passwordText: ReusableText = {
        let t = ReusableText(title:"Strong password")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var alreadyMemberLabel: UILabel = {
        let l = UILabel()
        l.text = "Already a member? Login"
        l.textAlignment = .center
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        l.textColor = .gray
        let attributedText = NSMutableAttributedString(string: l.text!)
        let range = (l.text! as NSString).range(of: "Login")
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        l.attributedText = attributedText
        l.isUserInteractionEnabled = true
        gestureRecognizer(to: l, action: #selector(showLogin))
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameText, surnameText,numberText ,emailText, passwordContainer])
        scrollView.addSubview(s)
        s.axis = .vertical
        s.spacing = 12
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var eyeButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "eye"), for: .normal)
        b.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        b.tintColor = .gray
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return b
    }()
    
    private lazy var signUp: ReusableButton = {
        let b = ReusableButton(title: "Sign Up") {
            [weak self] in self?.signUpClicked()
        }
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        
    }
    
    override func configureUI() {
        super.configureUI()
        [titleLabel,scrollView,signUp,alreadyMemberLabel].forEach {view.addSubview($0)}
        configureConstraints()
        configureText()
        configureViewModel()
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:24),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: signUp.topAnchor, constant: -52)
            
        ])
        NSLayoutConstraint.activate([
            nameText.heightAnchor.constraint(equalToConstant: 48),
            nameText.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            surnameText.heightAnchor.constraint(equalToConstant: 48),
            surnameText.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            numberText.heightAnchor.constraint(equalToConstant: 48),
            numberText.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            emailText.heightAnchor.constraint(equalToConstant: 48),
            emailText.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            passwordContainer.heightAnchor.constraint(equalToConstant: 48),
            passwordContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            signUp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signUp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            signUp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -52),
            signUp.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            alreadyMemberLabel.topAnchor.constraint(equalTo: signUp.bottomAnchor, constant: 8),
            alreadyMemberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            alreadyMemberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            
        ])
    }
    
    fileprivate func configureViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func configureText() {
        [nameText,surnameText,numberText,emailText,passwordText].forEach {$0.delegate = self}
    }
    
    @objc fileprivate func signUpClicked() {
        viewModel.checkValidation()
        showLogin()
    }
    
    @objc fileprivate func togglePasswordVisibility() {
        passwordText.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc fileprivate func showLogin(){
        let controller = LoginController(viewModel: self.viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension RegisterController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let username = nameText.text else {return}
        guard let number = numberText.text else {return}
        guard let surname = surnameText.text else {return}
        guard let email = emailText.text else {return}
        guard let password = passwordText.text else {return}
           viewModel.username = username
           viewModel.surname = surname
           viewModel.email = email
           viewModel.password = password
           viewModel.number = number
    }
}

extension RegisterController:AuthSenderDelegate {
    func defaultUserDelegate(user: User) {}
     
    func errorMessage(error: String) {
        showMessage(title: "Warning",message: error)
    }

}



