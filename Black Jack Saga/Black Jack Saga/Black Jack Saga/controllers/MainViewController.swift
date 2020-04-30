//
//  ViewController.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/15/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
import AVFoundation

struct viewControllerStruct {
    var card = Card()
}
class MainViewController: UIViewController {

    @IBOutlet weak var myStack: UIStackView!
    var structure = viewControllerStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dealAction(_ sender: Any) {
        structure.card.shuffleCards()
     }
    
}
