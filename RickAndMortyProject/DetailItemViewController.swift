//
//  DetailItemViewController.swift
//  RickAndMortyProject
//
//  Created by LPIEM on 30/04/2021.
//

import UIKit

class DetailItemViewController: UIViewController {

    @IBOutlet var mydetailImage: UIImageView!
    
    @IBOutlet var myDetailName: UILabel!
    @IBOutlet var myDetailSpecie: UILabel!
    @IBOutlet var myDetailDate: UILabel!
    
    var myCharacter: SerieCharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mydetailImage.loadImage(from: myCharacter.imageURL)
        myDetailName.text = myCharacter.name
        myDetailSpecie.text = myCharacter.species
        // myDetailDate.text = myCharacter.createdDate

        
        // Do any additional setup after loading the view.
    }
    

}
