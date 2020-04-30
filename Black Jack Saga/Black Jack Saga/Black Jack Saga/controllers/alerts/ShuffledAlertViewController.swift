//
//  ShuffledAlertViewController.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/16/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit

class ShuffledAlertViewController: UIViewController {
    
    var time = 6
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if time == 4{
            UIView.animate(withDuration: 2.5,delay:0.4,options: .curveEaseOut,animations:{
                self.dismiss(animated: true, completion: nil)
            })
        }
    }

}
