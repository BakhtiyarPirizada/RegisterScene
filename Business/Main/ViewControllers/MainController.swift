//
//  MainController.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 12.11.24.
//

import UIKit
import RealmSwift // istifdae eleme
class MainController: BaseViewController {
    
    private var viewModel = MainViewModel()
    private var selectedIndex = Int()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.isScrollEnabled = true
        c.isPagingEnabled = true
        c.backgroundColor = .clear
        c.delegate = self
        c.dataSource = self
        c.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    private lazy var addCard: UIImageView = {
        let i = UIImageView()
        i.alpha = 1
        i.image = .addCard
        i.layer.cornerRadius = 20
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    private lazy var deleteCard: UIImageView = {
        let i = UIImageView()
        i.alpha = 1
        i.image = .deleteCard
        i.layer.cornerRadius = 20
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    private lazy var transfer: UIImageView = {
        let i = UIImageView()
        i.image = .card
        i.alpha = 1
        i.image = .transfer
        i.layer.cornerRadius = 20
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [addCard, deleteCard,transfer])
        s.axis = .horizontal
        s.distribution = .equalSpacing
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureUI() {
        super.configureUI()
        [cardCollection,stackView].forEach {view.addSubview($0)}
        configureButton()
        viewModelListener()
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            cardCollection.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0),
            cardCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            cardCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardCollection.bottomAnchor, constant: 60),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            
        ])
        NSLayoutConstraint.activate([
            addCard.heightAnchor.constraint(equalToConstant: 60),
            addCard.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            deleteCard.heightAnchor.constraint(equalToConstant: 60),
            deleteCard.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            transfer.heightAnchor.constraint(equalToConstant: 60),
            transfer.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    fileprivate func configureButton() {
        gestureRecognizer(to: addCard, action: #selector(addCardClicked))
        gestureRecognizer(to: deleteCard, action: #selector(deleteCardClicked))
        gestureRecognizer(to: transfer, action: #selector(transferClicked))
        
    }
    fileprivate func viewModelListener() {
        viewModel.callback = { [weak self] state in
            switch state {
            case .error(let message):
                self?.showMessage(title: message)
            }
        }
    }
    fileprivate func collectionViewReload() {
        DispatchQueue.main.async {
            self.cardCollection.reloadData()
        }
    }
  
    @objc func addCardClicked() {
        viewModel.createCard()
        collectionViewReload()
        
    }
    @objc func deleteCardClicked() {
        viewModel.deleteRealm(index: selectedIndex)
        collectionViewReload()
    }
    @objc func transferClicked() {
        let controller  = TransferController(viewModel: TransferViewModel())
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func scrollToLast() {
        let newIndexPath = IndexPath(item: viewModel.cards!.count - 1, section: 0)
        self.cardCollection.scrollToItem(at:  newIndexPath, at: .centeredHorizontally, animated: true)
        
//        guard let item = viewModel.cards?[viewModel.cards!.count - 1] else {return}
    }
    
}
extension MainController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getList()
        return viewModel.cards?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollection.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell ?? CardCell()
        cell.layer.cornerRadius = 12
        selectedIndex = indexPath.row
        viewModel.getList()
        guard let card = viewModel.cards?[indexPath.row] else { return cell }
        cell.panLabel.text = card.pan ?? "asdfgh"
        cell.dateLabel.text = card.date ?? "asfdgfhgjhmhngbfdvs"
        if card.cardType == .visa {
            cell.typeImage.image = .visa
        }else {
            cell.typeImage.image = .master
        }
        collectionViewReload()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
