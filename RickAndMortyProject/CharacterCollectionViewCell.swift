//
//  CharacterCollectionViewCell.swift
//  RickAndMortyProject
//
//  Created by LPIEM on 03/03/2021.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var characterImage: UIImageView!
    
    @IBOutlet var characterName: UILabel!
    
    @IBOutlet var characterDescription: UILabel!
    
    var myCharacter: SerieCharacter? = nil
    
}
