//
//  CardListCell.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 20.11.24.
//

import UIKit

class CardListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        contentView.addViews(view: [typeImage,panLabel,balanceLabel])
        configureConstraints()
    }
    func configureCell(image:UIImage,pan:String,balance:String) {
        typeImage.image = image
        panLabel.text = pan
        balanceLabel.text = balance
    }
    fileprivate lazy var typeImage: UIImageView = {
        let i = UIImageView()
        i.alpha = 1
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    fileprivate  lazy var panLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .black
        l.text = "4169738849866599"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
   
    fileprivate lazy var balanceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.textColor = .blue
        l.text = "05/26"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    func configureConstraints() {
        NSLayoutConstraint.activate([
            typeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            typeImage.heightAnchor.constraint(equalToConstant: 16),
            typeImage.widthAnchor.constraint(equalToConstant: 16)
        ])

        NSLayoutConstraint.activate([
            panLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            panLabel.leftAnchor.constraint(equalTo: typeImage.rightAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            balanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            balanceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24)
        ])

       
    }
}
