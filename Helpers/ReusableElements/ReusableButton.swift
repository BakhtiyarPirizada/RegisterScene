//
//  ReusableButton.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 16.11.24.
//
import UIKit
class ReusableButton: UIButton {
    private var title:String
    private var action : ()->Void
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel?.textColor = .white
        backgroundColor = .buttonBGcolor
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        layer.cornerRadius = 12
    }
    @objc private func buttonClicked() {
        action()
    }
}


