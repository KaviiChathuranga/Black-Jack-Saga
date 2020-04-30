//
//  WinAlertViewController.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/19/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
protocol ResetView {
    func resetViews()
}

class WinAlertViewController: UIViewController {
    var time = 6
    var timer = Timer()
    var check = String()
    var resetView: ResetView!
    
    @IBOutlet weak var winnerImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if check == "true" {
            winnerImg.image = UIImage(named: "win_logo")
        }
        if check == "false"{
            winnerImg.image = UIImage(named: "lost_logo")
        }
        if check == "draw"{
            winnerImg.image = UIImage(named: "GameDrawLogo")
        }
        timeCounter()
        // redirectStandFormIdentifier
    }
    
    
    func timeCounter(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ShuffledAlertViewController.action)), userInfo: nil, repeats: true)
    }
    
    // wait (s) alert modal
    @objc func action(){
        time -= 1
        if time == 0 {
            time += 1
        }
        if time == 2{
            resetView.resetViews()
            UIView.animate(withDuration: 2.5,delay:0.4,options: .curveEaseOut,animations:{
                self.dismiss(animated: true, completion: nil)
//                self.performSegue(withIdentifier: "redirectGameIdentifier", sender: nil)
            },completion: {(finished: Bool) in  })
        }
        
    }
}
