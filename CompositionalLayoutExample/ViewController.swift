//
//  ViewController.swift
//  CompositionalLayoutExample
//
//  Created by Vikas Kumar on 29/05/22.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: "TopCell")
        collectionView.register(MiddleCell.self, forCellWithReuseIdentifier: "MiddleCell")
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: "BottomCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, env in
            if section == 0 {
                return self.createTopLayout()
            } else if section == 3 {
                return self.createBottomLayout()
            } else {
                return self.createMiddleLayout()
            }
        }
    }
    
    func createTopLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func createMiddleLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createBottomLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 7 }
        else if section == 3 { return 14 }
        else { return 4 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 {
            guard let middleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiddleCell", for: indexPath) as? MiddleCell else { return UICollectionViewCell() }
            return middleCell
        }
        else if indexPath.section == 3 {
            guard let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCell", for: indexPath) as? BottomCell else { return UICollectionViewCell() }
            return bottomCell
        }
        guard let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as? TopCell else { return UICollectionViewCell() }
        return topCell
    }
}

class TopCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8

        let holderView = UIView(frame: frame)
        holderView.backgroundColor = .yellow
        holderView.clipsToBounds = true
        holderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(holderView)
        
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MiddleCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12

        let holderView = UIView(frame: frame)
        holderView.backgroundColor = .green
        holderView.clipsToBounds = true
        holderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(holderView)
        
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12

        let holderView = UIView(frame: frame)
        holderView.backgroundColor = .blue
        holderView.clipsToBounds = true
        holderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(holderView)
        
        
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            holderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            holderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            holderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
