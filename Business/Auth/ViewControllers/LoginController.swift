//
//  LoginController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 02.11.24.
//

import UIKit
import RealmSwift
class LoginController: BaseViewController {
    
    private var viewModel : AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Welcome"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var emailText: UITextField = {
        let t = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: t.frame.height))
        t.layer.borderWidth = 1.0
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.placeholder = "Enter your email"
        t.textColor = .black
        t.delegate = self
        t.leftView = paddingView
        t.leftViewMode = .always
        t.layer.cornerRadius = 12
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
    
    private lazy var passwordText: UITextField = {
        let t = UITextField()
        t.setLeftPadding(10)
        t.layer.borderWidth = 1.0
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.placeholder = "Enter your password"
        t.textColor = .black
        t.delegate = self
        t.layer.cornerRadius = 12
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var newMemberLabel: UILabel = {
        let l = UILabel()
        l.text = "New member ? Register now"
        l.textAlignment = .center
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        l.textColor = .gray
        let attributedText = NSMutableAttributedString(string: l.text!)
        let range = (l.text! as NSString).range(of: "Register now")
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        l.attributedText = attributedText
        l.isUserInteractionEnabled = true
        gestureRecognizer(to: l, action: #selector(showRegister))
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [emailText, passwordContainer])
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
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Login", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        b.titleLabel?.textColor = .white
        b.backgroundColor = .buttonBGcolor
        b.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        b.layer.cornerRadius = 12
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        view.addSubview(loginButton)
        view.addSubview(newMemberLabel)
        configureConstraints()
        configureText()
        configureViewModel()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:24),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -52)
            
        ])
        NSLayoutConstraint.activate([
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
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -52),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            newMemberLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
            newMemberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            newMemberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            
        ])
    }
    
    fileprivate func configureText() {
        emailText.delegate = self
        passwordText.delegate = self
    }
    
    fileprivate func configureViewModel() {
        self.viewModel.delegate = self
    }
    
    @objc fileprivate func LoginClicked() {
        viewModel.logEmail = emailText.text ?? ""
        viewModel.logPassword =  passwordText.text ?? ""
        if !emailText.text!.isEmpty && !passwordText.text!.isEmpty {
            if viewModel.checkUser() {
                let controller = MainController()
                navigationController?.pushViewController(controller, animated: true)
            } else {showMessage(title: "Warning",message: "User is not found")}
        }else {showMessage(title: "Warning",message: "Fields cannot be emtpy")}
    }
    
    @objc func togglePasswordVisibility() {
        passwordText.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc  func showRegister(){
        navigationController?.popViewController(animated: true)
    }
}

extension LoginController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
}

extension LoginController:AuthSenderDelegate {
    func defaultUserDelegate(user: User) {
        emailText.text = user.email
        passwordText.text = user.password
    }
    
    func errorMessage(error: String) {}
   
}



