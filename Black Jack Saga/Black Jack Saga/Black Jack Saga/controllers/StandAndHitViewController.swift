//
//  StandAndHitViewController.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/16/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
import AVFoundation

class StandAndHitViewController: UIViewController {
    
    var structure = StandAndHitViewControllerStruct() // structure instance FROM StandAndHitViewExtentions Struct
    @IBOutlet weak var cardSetView: UIImageView!
    @IBOutlet weak var hitBtn: UIButton!
    @IBOutlet weak var myPointsLbl: UILabel!
    @IBOutlet weak var standBtn: UIButton!
    @IBOutlet weak var dealView: UIView!
    @IBOutlet weak var dealBtn: UIButton!
    @IBOutlet weak var dealerPointsLbl: UILabel!
    @IBOutlet weak var dealerStack: UIStackView!
    @IBOutlet weak var myStck: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideViews()
    }
    
    func hideViews(){
        hitBtn.isHidden = true
        standBtn.isHidden = true
        dealView.isHidden = false
    }
    func showViews(){
        print("Show views")
        hitBtn.isHidden = false
        standBtn.isHidden = false
        dealView.isHidden = true
    }
    
    func resetAll(){
        DispatchQueue.main.async {
            self.hideViews()
            self.dealerPointsLbl.text = "00"
            self.myPointsLbl.text = "00"
            for view in self.dealerStack.subviews{
                    view.removeFromSuperview()
            }
            for view in self.myStck.subviews{
                view.removeFromSuperview()
            }
        }
        hitBtn.isEnabled = true
        standBtn.isEnabled = true
        structure.cardArray.removeAll()
        structure.dealerCardArray.removeAll()
        structure.tempArray.removeAll()
        structure.tempDealerArray.removeAll()
        structure.tempCards.removeAll()
        structure.dealerCount = 0
        structure.myCount = 0
        structure.card = Card()
        structure.count = 0
        structure.standCount = 0
        structure.time = 5
        structure.timer = Timer()
        structure.playerStackObjectList.removeAll()
        structure.dealerStackObjectList.removeAll()
        structure.lastValue = 0
    }
    
    func loadDefaultCards(){
        structure.cardArray.append(structure.card.get2DeafultCards()[0])
        structure.cardArray.append(structure.card.get2DeafultCards()[1])
       
        let imageView_1 = UIImageView()
        imageView_1.contentMode = .scaleAspectFit
        imageView_1.translatesAutoresizingMaskIntoConstraints = false

        let imageView_2 = UIImageView()
        imageView_2.contentMode = .scaleAspectFit
        imageView_2.translatesAutoresizingMaskIntoConstraints = false

        imageView_1.image = UIImage(named: structure.cardArray[0].getImageName())
         structure.playerStackObjectList.append(structure.cardArray[0])
     
        imageView_2.image = UIImage(named: structure.cardArray[1].getImageName())
         structure.playerStackObjectList.append(structure.cardArray[1])

        imageView_1.isHidden = true
        imageView_2.isHidden = true
        self.myStck.addArrangedSubview(imageView_1)
        self.myStck.addArrangedSubview(imageView_2)
        
        UIView.animate(withDuration: 0.5,delay:0.4,options: .curveEaseOut,animations:{
            imageView_1.isHidden = false
            imageView_2.isHidden = false
        })
        
        structure.tempArray = structure.card.getSingleCard()
        
        _ = structure.playerStackObjectList.map({ (value) -> Void in
            structure.lastValue += value.getValue()
        })
        
        if structure.lastValue > 21 {
            structure.lastValue = 0
            for x in 0 ... structure.playerStackObjectList.count-1{
                if structure.playerStackObjectList[x].getType() == "King" && structure.playerStackObjectList[x].getValue() == 11{
                    let card = structure.playerStackObjectList[x]
                    structure.playerStackObjectList[x] = Card.init(imageName: card.getImageName(), value: 1, type: card.getType())
                    break
                }
            }
        }else{
            myPointsLbl.text = "\(structure.lastValue)"
        }
        
        structure.lastValue = 0
        _ = structure.playerStackObjectList.map({ (value) -> Void in
            structure.lastValue += value.getValue()
        })
        
        myPointsLbl.text = "\(structure.lastValue)"
        if structure.lastValue == 21{
            playSound(type: "win")
            hitBtn.isEnabled = true
            performSegue(withIdentifier: "winIdentifier", sender: "true")
            hitBtn.isEnabled = false
         }
    }
    
    func loadDelearCards(){
        structure.dealerCardArray.append(structure.card.getDealerDeafultCards()[0])
        
        let delearImage_1 = UIImageView()
        let delearImage_2 = UIImageView()
        
        delearImage_1.contentMode = .scaleAspectFit
        delearImage_1.translatesAutoresizingMaskIntoConstraints = false
        
        delearImage_2.contentMode = .scaleAspectFit
        delearImage_2.translatesAutoresizingMaskIntoConstraints = false
        
        delearImage_1.image = UIImage(named: "red_back")
        delearImage_2.image = UIImage(named: structure.dealerCardArray[0].getImageName())
        structure.dealerStackObjectList.append(structure.dealerCardArray[0])
       
        delearImage_1.isHidden = true
        delearImage_2.isHidden = true
        dealerStack.addArrangedSubview(delearImage_1)
        dealerStack.addArrangedSubview(delearImage_2)
        dealerStack.alignment = .bottom
        
        UIView.animate(withDuration: 0.5,delay:0.4,options: .curveEaseOut,animations:{
            delearImage_1.isHidden = false
            delearImage_2.isHidden = false
        })
        structure.tempDealerArray = structure.card.getSingleDealerCard()
        
        _ = structure.dealerStackObjectList.map({ (value) -> Void in
            structure.dealerCount += value.getValue()
        })
        
        if structure.dealerCount > 21 {
            structure.dealerCount = 0
            for x in 0 ... structure.dealerStackObjectList.count-1{
                if structure.dealerStackObjectList[x].getType() == "King" && structure.dealerStackObjectList[x].getValue() == 11{
                    let card = structure.dealerStackObjectList[x]
                    structure.dealerStackObjectList[x] = Card.init(imageName: card.getImageName(), value: 1, type: card.getType())
                    break
                }
            }
        }else{
            dealerPointsLbl.text = "\(structure.dealerCount)"
        }
        
        structure.dealerCount = 0
        _ = structure.dealerStackObjectList.map({ (value) -> Void in
            structure.dealerCount += value.getValue()
        })
         dealerPointsLbl.text = "\(structure.dealerCount)"
    }

    @IBAction func dealAction(_ sender: Any) {
        self.showViews()
        loadDefaultCards()
        loadDelearCards()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
            if self.myPointsLbl.text == "21"{
                self.performSegue(withIdentifier: "winIdentifier", sender: "true")
            }else{
                self.playSound(type: "shuffle")
                self.cardSetView.rotate360Degrees()
                self.performSegue(withIdentifier: "shuffledIdentifier", sender: nil)
            }
        })
    }
    func countDealerValues(){
        dealerPointsLbl.text = "\(structure.dealerCount)"
    }
    
    @IBAction func hitAction(_ sender: Any) {
        hitBtnControll()
    }
    
    @IBAction func standAction(_ sender: Any) {
        hitBtn.isEnabled = false
        standBtnControll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "winIdentifier" {
            
            let controller = segue.destination as! WinAlertViewController
            controller.resetView = self
            let condition = sender as! String
            if condition == "true" {
                controller.check = "true"
            }
            if condition == "false"{
                controller.check = "false"
            }
            if condition == "draw"{
                controller.check = "draw"
            }
         }
    }
    
}

extension StandAndHitViewController: ResetView{
    func resetViews() {
         resetAll()
    }
}
