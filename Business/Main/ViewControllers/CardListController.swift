//
//  CardListController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 20.11.24.
//

import UIKit

class CardListController: UIViewController {
    private let viewModel: CardListViewModel
    
    init(viewModel: CardListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardTable: UITableView = {
        let t = UITableView()
        t.backgroundColor = .clear
        t.register(CardListCell.self, forCellReuseIdentifier: "CardListCell")
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 48
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cardTable)
        configureConstraints()
    }
    func configureConstraints() {
        NSLayoutConstraint.activate([
            cardTable.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            cardTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            cardTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            cardTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
extension CardListController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getList()
        return  viewModel.cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardTable.dequeueReusableCell(withIdentifier: "CardListCell") as? CardListCell ?? CardListCell()
        viewModel.getList()
        guard let card = viewModel.cards?[indexPath.row] else {return cell}
        cell.configureCell(
            image: UIImage(named: "\(card.cardType!)") ?? .add,
            pan: "**** **** **** \(card.pan?.last4Chars ?? "****")",
            balance: String("\(card.balance) AZN"))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
  }
    
    
}
