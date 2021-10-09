//
//  Settings.swift
//  Outline
//
//  Created by Apple on 30/10/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Settings: UIViewController {
    
    var signoutbutton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        signoutbutton = UIButton(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        signoutbutton.setTitle("Log out", for: .normal)
        signoutbutton.addTarget(self, action: #selector(LogoutPressed), for: .touchUpInside)
        signoutbutton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(signoutbutton)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func LogoutPressed()
    {
        PFUser.logOut()
        PFUser.current() == nil
        self.dismiss(animated: true, completion: nil)
    
    }

}
