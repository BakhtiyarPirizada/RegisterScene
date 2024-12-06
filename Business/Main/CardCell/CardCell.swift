//
//  CardCell.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//

import UIKit

class CardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var panLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .white
        l.text = "4169738849866599"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    lazy var balanceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .white
        l.text = "10 Azn"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .white
        l.text = "05/26"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var BGImage: UIImageView = {
        let i = UIImageView()
        i.image = .card
        i.alpha = 1
        i.contentMode = .scaleAspectFill
        i.addSubview(panLabel)
        i.addSubview(dateLabel)
        i.addSubview(typeImage)
        i.addSubview(balanceLabel)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    lazy var typeImage: UIImageView = {
        let i = UIImageView()
        i.alpha = 1
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
   
    func configureConstraints() {
        NSLayoutConstraint.activate([
            BGImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            BGImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:0),
            BGImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            BGImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            typeImage.topAnchor.constraint(equalTo: BGImage.topAnchor, constant: 24),
            typeImage.rightAnchor.constraint(equalTo: BGImage.rightAnchor, constant:-48),
            typeImage.heightAnchor.constraint(equalToConstant: 30),
            typeImage.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            panLabel.bottomAnchor.constraint(equalTo: BGImage.bottomAnchor, constant: -25),
            panLabel.leftAnchor.constraint(equalTo: BGImage.leftAnchor, constant:30)

        ])
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: panLabel.centerYAnchor, multiplier: 0),
            dateLabel.leftAnchor.constraint(equalTo: panLabel.rightAnchor, constant:40)

        ])
        NSLayoutConstraint.activate([
            balanceLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: typeImage.centerYAnchor, multiplier: 0),
            balanceLabel.leftAnchor.constraint(equalTo: BGImage.leftAnchor, constant:40)

        ])
        
    }
    fileprivate func configureUI() {
        self.backgroundColor = .card
        contentView.addSubview(BGImage)
    }
    func configureCell(pan:String,date:String,balance:String,type:CardType?) {
        panLabel.text = pan
        dateLabel.text = date
        balanceLabel.text = balance
        if type == .visa {
            typeImage.image = .visa
        }else {
            typeImage.image = .master
        }
    }
    
}
