//
//  BaseViewController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 04.11.24.
//

import UIKit

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var BGImage: UIImageView = {
        let i = UIImageView()
        i.image = .bg
        i.backgroundColor = .bg
        i.alpha = 1
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        view.insertSubview(BGImage, at: 0)
        NSLayoutConstraint.activate([
            BGImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            BGImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0),
            BGImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            BGImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
       
        
    }
    
    open func configureUI() {
        
    }
    
    open func configureConstraints() {
        
    }

}
