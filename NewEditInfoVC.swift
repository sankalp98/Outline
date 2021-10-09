//
//  NewEditInfoVC.swift
//  Outline
//
//  Created by Apple on 30/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class NewEditInfoVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate
{
    var user : User = User.current()!
    
    var NameTextField: UITextField = UITextField()
    var UsernameTextField: UITextField = UITextField()
    var InfoTextView: UITextView = UITextView()
    var ProfilePictureImageView: PFImageView = PFImageView()
    var CoverPictureImageView: PFImageView = PFImageView()
    var heightConstraint: NSLayoutConstraint!
    var fullScrollView: UIScrollView = UIScrollView()
    var fullContentView: UIView = UIView()
    
    let image = UIImagePickerController()
    var ProfilePictureTapped: Bool = false
    var ProfilePictureChanged: Bool = false
    var CoverPictureChanged: Bool = false
    var ProfilePictureRemoved: Bool = false
    var CoverPictureRemoved: Bool = false
    var imageFile: PFFile!
    var imageData: Data!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var CoverPictureTapped: Bool = false
    
    var saveButton: UIBarButtonItem!
    
    var newFrameSize:CGSize = CGSize()
    
    var tapGestRecog: UITapGestureRecognizer = UITapGestureRecognizer()
    var CovtapGestRecog: UITapGestureRecognizer = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.edgesForExtendedLayout = UIRectEdge()
        
        image.delegate = self
        image.allowsEditing = true
        
        self.tapGestRecog = UITapGestureRecognizer(target: self, action: #selector(NewEditInfoVC.ProfTappedImage(_:)))
        self.CovtapGestRecog = UITapGestureRecognizer(target: self, action: #selector(NewEditInfoVC.CovTappedImage(_:)))
        
        self.view.addSubview(fullScrollView)
        fullScrollView.translatesAutoresizingMaskIntoConstraints = false
        //fullScrollView.backgroundColor = UIColor.yellowColor()
        fullScrollView.delegate = self
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.alwaysBounceVertical = true
        fullScrollView.contentSize = self.view.frame.size
        fullScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        
        self.fullScrollView.addSubview(fullContentView)
        fullContentView.translatesAutoresizingMaskIntoConstraints = false
        //fullScrollView.backgroundColor = UIColor.yellowColor()
        fullContentView.frame = self.view.frame
        let tapGR = UITapGestureRecognizer()
        tapGR.numberOfTapsRequired = 1
        tapGR.addTarget(self, action: #selector(NewEditInfoVC.ContentViewTapped))
        fullContentView.addGestureRecognizer(tapGR)
        
        self.fullContentView.addSubview(NameTextField)
        //NameTextField.backgroundColor = UIColor.yellowColor()
        NameTextField.translatesAutoresizingMaskIntoConstraints = false
        //NameTextField.text = "Sankalp Kasale"
        NameTextField.font = UIFont(name: "Helvetica Neue-Light", size: 12)
        NameTextField.text = "Name"
        NameTextField.textColor = UIColor.lightGray
        
        self.fullContentView.addSubview(UsernameTextField)
        //UsernameTextField.backgroundColor = UIColor.yellowColor()
        UsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        //UsernameTextField.text = "sankalp_kaslee"
        UsernameTextField.font = UIFont(name: "Helvetica Neue-Light", size: 12)
        UsernameTextField.text = self.user.username
        
        self.fullContentView.addSubview(InfoTextView)
        InfoTextView.delegate = self
        InfoTextView.translatesAutoresizingMaskIntoConstraints = false
        InfoTextView.backgroundColor = UIColor.yellow
        InfoTextView.text = "Bio"
        InfoTextView.font = UIFont(name: "Helvetica Neue-Light", size: 12)
        if self.user.Status != nil
        {
            self.InfoTextView.text = self.user.Status
            InfoTextView.textColor = UIColor.black
            let fixedWidth = InfoTextView.frame.size.width - 6
            InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            self.newFrameSize = InfoTextView.frame.size
            newFrameSize = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            InfoTextView.frame.size = newFrameSize
            InfoTextView.isScrollEnabled = false
        }
        else
        {
            InfoTextView.text = "Bio"
            InfoTextView.textColor = UIColor.lightGray
            let fixedWidth = InfoTextView.frame.size.width - 6
            InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            self.newFrameSize = InfoTextView.frame.size
            newFrameSize = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            InfoTextView.frame.size = newFrameSize
            InfoTextView.isScrollEnabled = false
        }
        
        self.fullContentView.addSubview(ProfilePictureImageView)
        ProfilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        ProfilePictureImageView.layer.cornerRadius = 30
        ProfilePictureImageView.backgroundColor = UIColor(hex: "#D3D3D3")
        ProfilePictureImageView.contentMode = .scaleAspectFill
        ProfilePictureImageView.clipsToBounds = true
        ProfilePictureImageView.isUserInteractionEnabled = true
        ProfilePictureImageView.layer.borderWidth = 0.5
        ProfilePictureImageView.layer.borderColor = UIColor.gray.cgColor
        ProfilePictureImageView.addGestureRecognizer(self.tapGestRecog)
        if self.user.ProfilePicture != nil
        {
            self.ProfilePictureImageView.file = self.user.ProfilePicture
            self.ProfilePictureImageView.load(inBackground: { (image, error) -> Void in
                if error == nil
                {
                    //...
                }
                }, progressBlock: { (percent) -> Void in
                    //..
            })
        }
        else
        {
            self.ProfilePictureImageView.image = UIImage(named: "lolwa.png")
        }
        
        self.fullContentView.addSubview(CoverPictureImageView)
        CoverPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        CoverPictureImageView.layer.cornerRadius = 0
        CoverPictureImageView.backgroundColor = UIColor(hex: "#D3D3D3")
        CoverPictureImageView.contentMode = .scaleAspectFill
        CoverPictureImageView.clipsToBounds = true
        CoverPictureImageView.isUserInteractionEnabled = true
        CoverPictureImageView.addGestureRecognizer(self.CovtapGestRecog)
        if self.user.CoverPicture != nil
        {
            self.CoverPictureImageView.file = self.user.CoverPicture
            self.CoverPictureImageView.load(inBackground: { (image, error) -> Void in
                if error == nil
                {
                    //...
                }
                }, progressBlock: { (percent) -> Void in
                    //..
            })
        }
        else
        {
            self.CoverPictureImageView.image = UIImage(named: "lolwa.png")
        }
        
        self.saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(NewEditInfoVC.SaveButtonPressed))
        self.navigationItem.setRightBarButton(saveButton, animated: true)
        
        self.heightConstraint = NSLayoutConstraint(item: InfoTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: newFrameSize.height)
        
        self.addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let fixedWidth = InfoTextView.frame.size.width - 6
        InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = InfoTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrameSize = InfoTextView.frame.size
        newFrameSize = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        InfoTextView.frame.size = newFrameSize
        self.heightConstraint = NSLayoutConstraint(item: InfoTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: newFrameSize.height)
        self.heightConstraint.isActive = true
    }
    
    func addConstraints()
    {
        self.view.addConstraint(NSLayoutConstraint(item: fullScrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fullScrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fullScrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fullScrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        
        self.fullScrollView.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .top, relatedBy: .equal, toItem: self.fullScrollView, attribute: .top, multiplier: 1, constant: 0))
        self.fullScrollView.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .left, relatedBy: .equal, toItem: self.fullScrollView, attribute: .left, multiplier: 1, constant: 0))
        self.fullScrollView.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .right, relatedBy: .equal, toItem: self.fullScrollView, attribute: .right, multiplier: 1, constant: 0))
        self.fullScrollView.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .bottom, relatedBy: .equal, toItem: self.fullScrollView, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: fullContentView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        
        self.fullContentView.addConstraint(NSLayoutConstraint(item: NameTextField, attribute: .top, relatedBy: .equal, toItem: self.fullContentView, attribute: .top, multiplier: 1, constant: 10))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: ProfilePictureImageView, attribute: .top, relatedBy: .equal, toItem: NameTextField, attribute: .top, multiplier: 1, constant: 0))
        
        self.fullContentView.addConstraintsWithFormat("H:|-5-[v0]-5-[v1(60)]-5-|", views: NameTextField, ProfilePictureImageView)
        
        self.fullContentView.addConstraint(NSLayoutConstraint(item: ProfilePictureImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        
        self.fullContentView.addConstraint(NSLayoutConstraint(item: UsernameTextField, attribute: .top, relatedBy: .equal, toItem: NameTextField, attribute: .bottom, multiplier: 1, constant: 10))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: UsernameTextField, attribute: .left, relatedBy: .equal, toItem: NameTextField, attribute: .left, multiplier: 1, constant: 0))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: UsernameTextField, attribute: .right, relatedBy: .equal, toItem: NameTextField, attribute: .right, multiplier: 1, constant: 0))
        
        //self.heightConstraint.active = true
        
        self.fullContentView.addConstraint(NSLayoutConstraint(item: InfoTextView, attribute: .top, relatedBy: .equal, toItem: ProfilePictureImageView, attribute: .bottom, multiplier: 1, constant: 10))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: InfoTextView, attribute: .right, relatedBy: .equal, toItem: self.fullContentView, attribute: .right, multiplier: 1, constant: -3))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: InfoTextView, attribute: .left, relatedBy: .equal, toItem: self.fullContentView, attribute: .left, multiplier: 1, constant: 3))
        
        self.fullContentView.addConstraint(NSLayoutConstraint(item: CoverPictureImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: CoverPictureImageView, attribute: .top, relatedBy: .equal, toItem: InfoTextView, attribute: .bottom, multiplier: 1, constant: 5))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: CoverPictureImageView, attribute: .right, relatedBy: .equal, toItem: self.fullContentView, attribute: .right, multiplier: 1, constant: -3))
        self.fullContentView.addConstraint(NSLayoutConstraint(item: CoverPictureImageView, attribute: .left, relatedBy: .equal, toItem: self.fullContentView, attribute: .left, multiplier: 1, constant: 3))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.InfoTextView.resignFirstResponder()
        self.NameTextField.resignFirstResponder()
        self.UsernameTextField.resignFirstResponder()
    }
    
    @objc func ProfTappedImage(_ sender: AnyObject){
        print("User tapped on Image")
        //self.ProfilePictureTapped = true
        let  reportMenu = UIAlertController(title: "Change Profile Picture", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        //let PhotosReport = UIAlertAction(title: "Use Photos", style: UIAlertActionStyle.Default, handler: nil)
        let PhotosReport = UIAlertAction(title: "Use Photos", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.image, animated: true, completion: nil)
            self.ProfilePictureTapped = true
        }
        let CameraReport = UIAlertAction(title: "Use Camera", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.image.sourceType = UIImagePickerControllerSourceType.camera
            self.present(self.image, animated: true, completion: nil)
            self.ProfilePictureTapped = true
        }
        
        let RemoveReport = UIAlertAction(title: "Remove", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.ProfilePictureImageView.image = UIImage(named: "lolwa.png")
            self.user.ProfilePicture = nil
            //self.ProfilePictureTapped = true
            self.ProfilePictureRemoved = true
        }
        
        let cancelReport = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        reportMenu.addAction(PhotosReport)
        reportMenu.addAction(CameraReport)
        reportMenu.addAction(cancelReport)
        reportMenu.addAction(RemoveReport)
        
        self.present(reportMenu, animated: true, completion: nil)
        
        
    }
    
    @objc func CovTappedImage(_ sender: AnyObject){
        print("User tapped on Image")
        //self.CoverPictureTapped = true
        let  reportMenu = UIAlertController(title: "Change Profile Picture", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        //let PhotosReport = UIAlertAction(title: "Use Photos", style: UIAlertActionStyle.Default, handler: nil)
        let PhotosReport = UIAlertAction(title: "Use Photos", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.image, animated: true, completion: nil)
            self.CoverPictureTapped = true
        }
        let CameraReport = UIAlertAction(title: "Use Camera", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.image.sourceType = UIImagePickerControllerSourceType.camera
            self.present(self.image, animated: true, completion: nil)
            self.CoverPictureTapped = true
        }
        let RemoveReport = UIAlertAction(title: "Remove", style: UIAlertActionStyle.default) { (yolo) -> Void in
            self.CoverPictureImageView.image = UIImage(named: "lolwa.png")
            self.user.CoverPicture = nil
            //self.CoverPictureTapped = true
            self.CoverPictureRemoved = true
        }
        let cancelReport = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        reportMenu.addAction(PhotosReport)
        reportMenu.addAction(CameraReport)
        reportMenu.addAction(cancelReport)
        reportMenu.addAction(RemoveReport)
        
        self.present(reportMenu, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.ProfilePictureTapped = false
        self.CoverPictureTapped = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        self.dismiss(animated: true, completion: nil)
        
        if self.ProfilePictureTapped == true
        {
            self.ProfilePictureImageView.image = image
            self.ProfilePictureTapped = false
            
            self.ProfilePictureChanged = true
            
            self.ProfilePictureImageView.image = image
            
        }
        else if self.CoverPictureTapped == true
        {
            self.CoverPictureImageView.image = image
            self.CoverPictureTapped = false
            
            self.CoverPictureChanged = true
            
            self.CoverPictureImageView.image = image
        }
        
    }
    
    @objc func SaveButtonPressed()
    {
        if self.ProfilePictureChanged == true || self.CoverPictureChanged == true || self.ProfilePictureRemoved == true || self.CoverPictureRemoved == true
        {
            activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
            activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if self.ProfilePictureChanged == true
            {
                self.imageData = UIImagePNGRepresentation((self.ProfilePictureImageView.image)!)
                
                self.imageFile = PFFile(name: "image.png", data: imageData)
                
                self.user.ProfilePicture = imageFile
                
            }
            
            if self.ProfilePictureRemoved == true
            {
                self.user.ProfilePicture = nil
            }
            
            if self.CoverPictureChanged == true
            {
                self.imageData = UIImagePNGRepresentation((self.CoverPictureImageView.image)!)
                
                self.imageFile = PFFile(name: "image.png", data: imageData)
                
                self.user.CoverPicture = imageFile
                
            }
            if self.CoverPictureRemoved == true
            {
                self.user.CoverPicture = nil
            }
            
            /*if self.InfoTextView.text != ""
            {
                self.user.Status = self.InfoTextView.text
                
            }
            if self.InfoTextView.text == ""
            {
                self.user.Status = self.InfoTextView.text
                
            }*/
            if self.UsernameTextField.text != ""
            {
                self.user.username = self.UsernameTextField.text
            }
            self.user.Status = self.InfoTextView.text
            self.user.saveInBackground(block: { (succeeded, error) -> Void in
                if error == nil
                {
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            })
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("GG")
        if self.InfoTextView.text == ""
        {
            
        }
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrameSize = textView.frame.size
        newFrameSize = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame.size = newFrameSize
        self.heightConstraint.constant = newFrameSize.height
    }
    
    @objc func ContentViewTapped()
    {
        print("Content view tapped")
        self.InfoTextView.resignFirstResponder()
        self.NameTextField.resignFirstResponder()
        self.UsernameTextField.resignFirstResponder()
    }
}
