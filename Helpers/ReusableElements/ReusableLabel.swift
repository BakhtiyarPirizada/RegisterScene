//
//  ReusableLabel.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 16.11.24.
//
import UIKit
class ReusableLabel:UILabel {
    private var title: String
    private var size: CGFloat
    init(title: String,size:CGFloat) {
        self.size = size
        self.title = title
        super.init(frame: .zero)
        ConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func ConfigureUI() {
        text = title
        textAlignment = .center
        numberOfLines = 0
        setLeftPaddingForLabel(padding: 2)
        font = UIFont.systemFont(ofSize: size, weight: .heavy)
        textColor = .black
    }
}
