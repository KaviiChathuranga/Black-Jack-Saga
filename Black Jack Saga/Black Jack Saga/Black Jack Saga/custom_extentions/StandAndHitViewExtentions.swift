import Foundation
import AVFoundation
import UIKit

struct StandAndHitViewControllerStruct {
    var card = Card()
    var cardArray = [Card]()
    var dealerCardArray = [Card]()
    var tempDealerArray = [Card]()
    var tempArray = [Card]()
    var tempCards = [Card]()
    var myCount = 0
    var dealerCount = 0
    var time = 5
    var timer = Timer()
    var audioPlayer:AVAudioPlayer!
    static var backgroundAudioPlayer:AVAudioPlayer!
    static var audioFilePath = MusicPlay(MusicName: "playing-cards-170817-08")
    static var winFilePath = MusicPlay(MusicName: "little_robot_sound_factory_Jingle_Win_Synth_06")
    static var lostFilePath = MusicPlay(MusicName: "zapsplat_multimedia_game_retro_musical_descend_fail_negative_21484")
    static var drawFilePath = MusicPlay(MusicName: "zapsplat_vehicles_bicycle_bell_single_ring_ping_29516")
    var count = 0
    var standCount = 0
    var playerStackObjectList = [Card]()
    var dealerStackObjectList = [Card]()
    var lastValue = 0
 }
class StandAndHitViewExtentions{} //

extension StandAndHitViewController{
    // play sound effects
    func playSound(type : String){
            if type == "shuffle"{
                StandAndHitViewControllerStruct.audioFilePath.startOneTimeMusic()
            }
            if type == "win"{
                StandAndHitViewControllerStruct.winFilePath.startOneTimeMusic()
            }
            if type == "lost"{
                StandAndHitViewControllerStruct.lostFilePath.startOneTimeMusic()
            }
            if type == "draw"{
               StandAndHitViewControllerStruct.drawFilePath.startOneTimeMusic()
            }
    }
    
    // start timer
    func callTimer(){
         structure.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ShuffledAlertViewController.action)), userInfo: nil, repeats: true)
    }
    @objc func action(){
        structure.time -= 1
        if structure.time == 0 {
            structure.time += 1
        }
        if structure.time == 3{
            UIView.animate(withDuration: 1,delay:0.4,options: .curveEaseOut,animations:{
                self.standBtn.sendActions(for: .touchUpInside)
                self.structure.time = 5
            })
        }
    }
    
    // Button Action events
    func hitBtnControll(){
        structure.lastValue = 0
        playSound(type: "shuffle")
        let card = structure.tempArray.popLast()
      
        structure.playerStackObjectList.append(card!)
        
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
      
        loadPlayerAnimation(card: card)
        
            if structure.lastValue <= 21 {
                if structure.lastValue == 21 {
                    playSound(type: "win")
                    hitBtn.isEnabled = true
                    performSegue(withIdentifier: "winIdentifier", sender: "true")
                    hitBtn.isEnabled = false
                }else{
                    hitBtn.isEnabled = true
                }
            }else{
                playSound(type: "lost")
                hitBtn.isEnabled = true
                performSegue(withIdentifier: "winIdentifier", sender: "false")
            }
            myPointsLbl.text = "\(structure.lastValue)"
    }
    
    func standBtnControll(){
        structure.dealerCount = 0
        self.structure.timer.invalidate()
        standBtn.isEnabled = false
        playSound(type: "shuffle")
        let myPoints = Int(myPointsLbl.text!)
        let delaerPoints = Int(dealerPointsLbl.text!)
        let card = structure.tempDealerArray.popLast()
        structure.dealerStackObjectList.append(card!)
        loadDealerAnimation(card: card)
        
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
        
        if structure.dealerCount > myPoints! && structure.dealerCount <= 21{
            playSound(type: "lost")
            dealerPointsLbl.text = "\(structure.dealerCount)"
            self.structure.timer.invalidate()
            performSegue(withIdentifier: "winIdentifier", sender: "false")
            return
        }

        if structure.dealerCount > 21 {
            playSound(type: "win")
            standBtn.isEnabled = true
            performSegue(withIdentifier: "winIdentifier", sender: "true")
            return
        }
        
        if structure.dealerCount == 21 {
            playSound(type: "lost")
            dealerPointsLbl.text = "\(delaerPoints!)"
            self.structure.timer.invalidate()
            performSegue(withIdentifier: "winIdentifier", sender: "false")
            return
        }
        
        if structure.dealerCount < 21 {
            callTimer()
        }

    }
    
    func loadPlayerAnimation(card: Card!){
        let imageView_3 = UIImageView()
        imageView_3.image = UIImage(named: (card?.getImageName())!)
        if card?.getType() == "King"{
            imageView_3.restorationIdentifier = "King"
        }else{
            imageView_3.restorationIdentifier = ""
        }
        imageView_3.isHidden = true
        imageView_3.contentMode = .scaleAspectFit
        imageView_3.translatesAutoresizingMaskIntoConstraints = false
        self.myStck.addArrangedSubview(imageView_3)
        UIView.animate(withDuration: 0.4) {
            imageView_3.isHidden = false
        }
    }
    func loadDealerAnimation(card: Card!){
        structure.count += 1
        if structure.count == 1 {
            var imageView_3 = UIImageView()
            imageView_3.image = UIImage(named: (card?.getImageName())!)
            imageView_3.contentMode = .scaleAspectFit
            imageView_3.translatesAutoresizingMaskIntoConstraints = false
            imageView_3.isHidden = true
            UIView.animate(withDuration: 0.5) {
                for view in self.dealerStack.subviews{
                    UIView.transition(with: view, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    imageView_3 = view as! UIImageView
                    imageView_3.image = UIImage(named: (card?.getImageName())!)
                        if card?.getType() == "King"{
                            imageView_3.restorationIdentifier = "King"
                        }else{
                            imageView_3.restorationIdentifier = ""
                        }
                     return
                    
                    UIView.animate(withDuration: 0.3) {
                        imageView_3.isHidden = false
                    }
                }
            }
        }else{
            let imageView_3 = UIImageView()
            imageView_3.image = UIImage(named: (card?.getImageName())!)
            if card?.getType() == "King"{
                imageView_3.restorationIdentifier = "King"
            }else{
                imageView_3.restorationIdentifier = ""
            }
            imageView_3.contentMode = .scaleAspectFit
            imageView_3.translatesAutoresizingMaskIntoConstraints = false
            imageView_3.isHidden = true
            dealerStack.addArrangedSubview(imageView_3)
            UIView.animate(withDuration: 0.3) {
                imageView_3.isHidden = false
            }
        }
    }
}
