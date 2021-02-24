//
//  CollectionViewController.swift
//  RickAndMortyProject
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    private enum Section {
        case main
    }
    
    private enum Item: Hashable {
        case character(SerieCharacter)
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()

        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .character(let serieCharacter):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = serieCharacter.name
                cell.imageView?.loadImage(from: serieCharacter.imageURL) {
                    cell.setNeedsLayout()
                }
                cell.detailTextLabel?.text = DateFormatter.localizedString(from: serieCharacter.createdDate,
                                                                           dateStyle: .medium,
                                                                           timeStyle: .short)
            }
        })


        let snapshot = createSnapshot()
        diffableDataSource.apply(snapshot)
        
    }

}

private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout(sectionProvider: { (section, environment) -> NSCollectionLayoutSection? in
        let snapshot = self.diffableDataSource.snapshot()
        let currentSection = snapshot.sectionIdentifiers[section]
        
        switch currentSection {
        case .main:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(50))

            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitem: item,
                                                         count: 2)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10

            return section
        }
    })

    return layout
}

    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mainColorItems, toSection: .main)

        return snapshot
    }
