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
        
        print("test")
        
        collectionView.collectionViewLayout = createLayout()

        diffableDataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .character(let serieCharacter):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCollectionViewCell
                
                cell.characterName.text = serieCharacter.name
                //cell.characterImage.loadImage(from: serieCharacter.imageURL) {cell.setNeedsLayout()}
                cell.characterDescription.text = DateFormatter.localizedString(from: serieCharacter.createdDate,
                                                                           dateStyle: .medium,
                                                                           timeStyle: .short)
                return cell

            }
        })
        
        let snapshot = createSnapshot(serieCharacters: [])
        diffableDataSource.apply(snapshot)
        
        NetworkManager.shared.fetchCharacters { (result) in
            switch result {
            case .failure(let error):
                print(error)

            case .success(let paginatedElements):
                let serieCharacters = paginatedElements.decodedElements
                let snapshot = self.createSnapshot(serieCharacters: serieCharacters)

                DispatchQueue.main.async {
                    self.diffableDataSource.apply(snapshot)
                }
            }
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

        private func createSnapshot(serieCharacters: [SerieCharacter]) -> NSDiffableDataSourceSnapshot<Section, Item> {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections([.main])

            let items = serieCharacters.map{Item.character($0)}

            snapshot.appendItems(items, toSection: .main)

            return snapshot
        }

}


