//
//  AboutViewController.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/16/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppVersion() 
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        
        if `switch`.isOn{
        }else{
        }
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setAppVersion(){
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        aboutLbl.text = "App Version "+"\(appVersion!)"
    }

}
