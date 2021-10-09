//
//  practiceViewController.swift
//  BaeToBye
//
//  Created by Apple on 15/09/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import UIKit

class practiceViewController: UIViewController, xTableViewContentSizeHeight, TableViewContentSizeHeight {

    @IBOutlet weak var MainScrollView: UIScrollView!
    
    
    @IBOutlet weak var containerView1: UIView!
    
    let fuckyou: CGFloat = CGFloat()
    
    var hoolax:UIViewController = UIViewController()
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    //let newVC = storyboard?.instantiateViewControllerWithIdentifier("hola") as! profilePostsTableViewController
    
    var storyyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println("gg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //MainScrollView.contentSize.height = 1000
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("gg")
        
        
        
        let controller = storyboard?.instantiateViewControllerWithIdentifier("hola") as! profilePostsTableViewController
        self.hoolax = controller
        
        self.addChildViewController(controller)
        
        self.containerView1.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        //self.MainScrollView.contentSize.height = fuckyou
        
    }
    
    func callForHeightOfTableView(height: CGFloat)
    {
        /*self.MainScrollView.contentSize.height = height + self.containerView1.frame.origin.y
        self.containerViewHeightConstraint.constant = height
        self.fuckyou == height
        println("I got height \(height)")*/
    }
    
    
    func xcallForHeightOfTableView(height: CGFloat)
    {/*
        self.MainScrollView.contentSize.height = height + self.containerView1.frame.origin.y
        self.containerViewHeightConstraint.constant = height
        self.fuckyou == height
        println("I got height again \(height)")
*/
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.preferredContentSize
    }
    
    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        /*self.containerViewHeightConstraint.constant = 0.0
        self.containerViewHeightConstraint.constant = container.preferredContentSize.height + self.containerView1.frame.origin.y
        self.MainScrollView.contentSize.height = self.containerViewHeightConstraint.constant
*/
        
    }

    @IBAction func segmentedControlValueChanged(sender: AnyObject)
    {
        if sender.selectedSegmentIndex == 1
        {/*
            self.hoolax.willMoveToParentViewController(nil)
            self.hoolax.view.removeFromSuperview()
            self.hoolax.removeFromParentViewController()
            
            let controller = storyboard?.instantiateViewControllerWithIdentifier("gola") as! StatusesTableViewController
            self.hoolax = controller
            self.addChildViewController(controller)
            self.containerView1.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            */
        }
        else
        {
            /*
            self.hoolax.willMoveToParentViewController(nil)
            self.hoolax.view.removeFromSuperview()
            self.hoolax.removeFromParentViewController()
            
            let controller = storyboard?.instantiateViewControllerWithIdentifier("hola") as! profilePostsTableViewController
            self.hoolax = controller
            self.addChildViewController(controller)
            self.containerView1.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
*/
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
