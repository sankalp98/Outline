//
//  TestViewController.swift
//  BaeToBye
//
//  Created by Apple on 15/07/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class TestViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("success")

        // Do any additional setup after loading the view.
        /*if PFUser.currentUser() == nil
        {
            println("success")
            
            var logInViewController = PFLogInViewController()
            
            logInViewController.delegate = self
            
            var signUpViewController = PFSignUpViewController()
            
            signUpViewController.delegate = self
            
            logInViewController.signUpController = signUpViewController
            
            self.presentViewController(logInViewController, animated: true, completion: nil)
            
        }
        else
        {
            println("error")
            self.performSegueWithIdentifier("go", sender: self)
        }*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if PFUser.current() == nil
        {
            
            let logInViewController = PFLogInViewController()
            
            logInViewController.delegate = self
            
            logInViewController.fields = ([PFLogInFields.usernameAndPassword, PFLogInFields.logInButton, PFLogInFields.signUpButton, PFLogInFields.passwordForgotten, PFLogInFields.dismissButton, PFLogInFields.facebook, PFLogInFields.twitter])
            
            logInViewController.facebookPermissions = [ "friends_about_me" ]
            
            let signUpViewController = PFSignUpViewController()
            
            signUpViewController.delegate = self
            
            logInViewController.signUpController = signUpViewController
            
            self.present(logInViewController, animated: true, completion: nil)
            
        }
        else
        {
            //self.performSegue(withIdentifier: "go", sender: self)
            let vc = noloViewController()
            self.show(vc, sender: nil)
        }
        
    }
    func log(_ logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        print("user logged in")
        let vc = noloViewController()
        self.show(vc, sender: nil)
        //self.present(vc, animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
//    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
//        let username = info["username"] as! String
//        let password = info["password"] as! String
//        _ = info["email"] as! String
//        if !username.isEmpty || !password.isEmpty
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, shouldBeginSignUp info: [String : String]) -> Bool{
        let username = info["username"]! as String
        let password = info["password"]! as String
        _ = info["email"]! as String
        if !username.isEmpty || !password.isEmpty
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        print("user signed up")
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didFailToSignUpWithError error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
    func signUpViewControllerDidCancelSignUp(_ signUpController: PFSignUpViewController) {
        print("user cancelled sign up")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
