//
//  HellNoViewController.swift
//  BaeToBye
//
//  Created by Apple on 17/09/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit

class HellNoViewController: UIViewController {
    
    var hoolax:UIViewController = UIViewController()

    @IBOutlet weak var Container1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        let controller = storyboard?.instantiateViewControllerWithIdentifier("hola") as! profilePostsTableViewController
        self.hoolax = controller
        //controller.willMoveToParentViewController(self)
        self.addChildViewController(controller)
        //controller.view.frame = self.Container1.frame
        self.Container1.addSubview(controller.view)
        controller.didMoveToParentViewController(self)

    }
    
    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        self.Container1.frame.size.height = container.preferredContentSize.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        if sender.selectedSegmentIndex == 1
        {
            self.hoolax.willMoveToParentViewController(nil)
            self.hoolax.view.removeFromSuperview()
            self.hoolax.removeFromParentViewController()
            
            let controller = storyboard?.instantiateViewControllerWithIdentifier("gola") as! StatusesTableViewController
            self.hoolax = controller
            //controller.willMoveToParentViewController(self)
            self.addChildViewController(controller)
            //controller.view.frame = self.Container1.frame
            self.Container1.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            
        }
        else
        {
            self.hoolax.willMoveToParentViewController(nil)
            self.hoolax.view.removeFromSuperview()
            self.hoolax.removeFromParentViewController()
            
            let controller = storyboard?.instantiateViewControllerWithIdentifier("hola") as! profilePostsTableViewController
            self.hoolax = controller
            //controller.willMoveToParentViewController(self)
            self.addChildViewController(controller)
            //controller.view.frame = self.Container1.frame
            self.Container1.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
        }
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
