//
//  GatheringCreateVC.swift
//  Outline
//
//  Created by Apple on 03/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Photos
import Parse
import ParseUI
import CoreLocation
import GoogleMaps

class GatheringCreateVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, SelectedImageDelegator, UITextViewDelegate
{
    var CancelBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var PostBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .rgb(red: 240, green: 240, blue: 240)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.lightGray.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    var placename = ""
    
    var location : PFGeoPoint!
    
    var xplace : GMSPlace!
    
    let containerView = UIView()
    
    let SecondcontainerView = UIView()
    
    let DescriptionContainerView = UIView()
    
    let timeComponents = ["1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours", "7 hours", "8 hours", "9 hours", "10 hours", "11 hours", "12 hours", "13 hours", "14 hours", "15 hours", "16 hours", "17 hours", "18 hours", "19 hours", "20 hours", "21 hours", "22 hours", "23 hours", "24 hours"]
    
    let firstdayComponents = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    
    let firstmonthComponents = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    let firstyearComponents = ["18","19"]
    
    let endtimehourComponents = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    let endtimeminutesComponents = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let endtimesecondsComponents = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    let seconddayComponents = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    
    let secondmonthComponents = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    let secondyearComponents = ["18","19"]
    
    var ChooseImage = FLoatingButton()
    
    var FourthContainerView = UIView()
    
    var NameContainerView = UIView()
    
    var firstdaypicker : UIPickerView = UIPickerView()
    var firstmonthpicker : UIPickerView = UIPickerView()
    var firstyearpicker : UIPickerView = UIPickerView()
    
    var seconddaypicker : UIPickerView = UIPickerView()
    var secondmonthpicker : UIPickerView = UIPickerView()
    var secondyearpicker : UIPickerView = UIPickerView()
    
    var activityIndicator = UIActivityIndicatorView()
    
    let ThirdcontainerView = UIView()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.text = "23:59:59"
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.gray
        return label
    }()
    
    var CaptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        //label.text = "Select a place"
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.lightGray
        return label
    }()
    
    var nameTextField = UITextField()
    
    var descriptionTextView: UITextView!
    
    let eventStartDate = Date()
    let eventEndDate = Date()
    
    var isAnythingEmpty = true
    
    var heightconstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        CancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonPressed))
        self.navigationItem.leftBarButtonItem = CancelBarButtonItem
        
        PostBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(PostButtonPressed))
        //PostBarButtonItem.tintColor = UIColor.blue
        self.navigationItem.rightBarButtonItem = PostBarButtonItem
        
        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        let somesize = (self.view.frame.size.width/2)-50
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: somesize, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        SecondcontainerView.backgroundColor = .clear
        view.addSubview(SecondcontainerView)
        
        SecondcontainerView.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        self.SecondcontainerView.addSubview(ChooseImage)
        ChooseImage.translatesAutoresizingMaskIntoConstraints = false
        ChooseImage.backgroundColor = UIColor.clear
        ChooseImage.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        ChooseImage.setTitle("select image", for: UIControlState())
        ChooseImage.setTitleColor(UIColor.rgb(red: 93, green: 188, blue: 210), for: UIControlState())
        ChooseImage.addTarget(self, action: #selector(self.ChooseImageButtonPressed), for: UIControlEvents.touchUpInside)
        ChooseImage.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        SecondcontainerView.addConstraintsWithFormat("H:|[v0]|", views: ChooseImage)
        SecondcontainerView.addConstraintsWithFormat("V:|[v0]|", views: ChooseImage)
        
        NameContainerView.backgroundColor = .clear
        view.addSubview(NameContainerView)
        
        NameContainerView.anchor(top: SecondcontainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        
        let somefont = UIFont(name: "HelveticaNeue", size: 13)
        let placeholder = NSAttributedString(string: "Enter name here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: somefont!])
        
        nameTextField.attributedPlaceholder = placeholder
        nameTextField.textColor = UIColor.black
        nameTextField.font = UIFont(name: "HelveticaNeue", size: 13)
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        nameTextField.clearsOnBeginEditing = true
        NameContainerView.addSubview(nameTextField)
        
        NameContainerView.addConstraintsWithFormat("H:|[v0]|", views: nameTextField)
        NameContainerView.addConstraintsWithFormat("V:|[v0]|", views: nameTextField)
        
        DescriptionContainerView.backgroundColor = .white
        DescriptionContainerView.layer.cornerRadius = 5
        view.addSubview(DescriptionContainerView)
        
        DescriptionContainerView.anchor(top: NameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.descriptionTextView = UITextView()
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionTextView.text = "Enter Description"
        self.descriptionTextView.isScrollEnabled = false
        self.descriptionTextView.delegate = self
        self.descriptionTextView.font = UIFont(name: "HelveticaNeue", size: 13)
        //self.descriptionTextView.clearsOnInsertion = true
        self.descriptionTextView.resignFirstResponder()
        descriptionTextView.textAlignment = .center
        DescriptionContainerView.addSubview(descriptionTextView)
        
        self.heightconstraint = NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 31)
        heightconstraint.isActive = true
        
        DescriptionContainerView.addConstraintsWithFormat("H:|[v0]|", views: descriptionTextView)
        DescriptionContainerView.addConstraintsWithFormat("V:|[v0]|", views: descriptionTextView)
        
        ThirdcontainerView.backgroundColor = .clear
        view.addSubview(ThirdcontainerView)
        
        ThirdcontainerView.anchor(top: DescriptionContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 120)
        
        self.setUpDatepickerView()
        
        FourthContainerView.backgroundColor = .white
        view.addSubview(FourthContainerView)
        
        FourthContainerView.anchor(top: ThirdcontainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44)
        
        CaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let cplaceholder = NSAttributedString(string: "Search place", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: somefont!])
        
        CaptionLabel.attributedText = cplaceholder
        FourthContainerView.addSubview(CaptionLabel)
        
        FourthContainerView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: CaptionLabel)
        FourthContainerView.addConstraintsWithFormat("V:|-5-[v0]-5-|", views: CaptionLabel)
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(self.placeNameTapped))
        tapG.numberOfTapsRequired = 1
        CaptionLabel.addGestureRecognizer(tapG)
        
        /*let query = PFQuery(className: "Gathering")
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                for object in objects!
                {
                    let xobject = object as! Gathering
                    let formatter = DateFormatter()
                    formatter.dateStyle = .long
                    formatter.timeStyle = .medium
                    
                    //let startdateString = formatter.string(from: xobject.startDate)
                    //var x = xobject.endDate?
                    //let enddateString = formatter.string(from: xobject.endDate)
                    //print(startdateString)
                    //print(enddateString)
                    
                    //let gg1 = xobject.startDate
                    //let gg2 = xobject.endDate
                    
//                    let diff = gg2?.interval(ofComponent: .day, fromDate: gg1!)
//                    print(diff!)
//
//                    let diff2 = gg2?.interval(ofComponent: .month, fromDate: gg1!)
//                    print(diff2!)
//
//                    let diff3 = gg2?.interval(ofComponent: .minute, fromDate: gg1!)
//                    print(diff3!)
//
//                    let diff4 = gg2?.interval(ofComponent: .second, fromDate: gg1!)
//                    print(diff4!)
                    
                    //let diffInDays = Calendar.current.dateComponents([.day], from: gg1!, to: gg2!).day
                    //print(diffInDays)
                }
         }
            }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        firstdaypicker.selectRow(0, inComponent: 0, animated: true)
        firstmonthpicker.selectRow(0, inComponent: 0, animated: true)
        firstyearpicker.selectRow(0, inComponent: 0, animated: true)
        
        seconddaypicker.selectRow(0, inComponent: 0, animated: true)
        secondmonthpicker.selectRow(0, inComponent: 0, animated: true)
        secondyearpicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var gg = UITextView()
        gg = textView
        gg.sizeToFit()
        let tvheight = gg.frame.size.height
        self.heightconstraint.constant = tvheight
    }
    
    func setUpDatepickerView()
    {
        firstdaypicker = UIPickerView()
        firstdaypicker.delegate = self
        firstdaypicker.dataSource = self
        firstdaypicker.backgroundColor = UIColor.clear
        //firstdaypicker.selectRow(1, inComponent: 0, animated: true)
        
        firstmonthpicker = UIPickerView()
        firstmonthpicker.delegate = self
        firstmonthpicker.dataSource = self
        firstmonthpicker.backgroundColor = UIColor.clear
        //firstmonthpicker.selectRow(0, inComponent: 0, animated: true)
        
        firstyearpicker = UIPickerView()
        firstyearpicker.delegate = self
        firstyearpicker.dataSource = self
        firstyearpicker.backgroundColor = UIColor.clear
        //firstyearpicker.selectRow(0, inComponent: 0, animated: true)
        
        seconddaypicker = UIPickerView()
        seconddaypicker.delegate = self
        seconddaypicker.dataSource = self
        seconddaypicker.backgroundColor = UIColor.clear
        //seconddaypicker.selectRow(1, inComponent: 0, animated: true)
        
        secondmonthpicker = UIPickerView()
        secondmonthpicker.delegate = self
        secondmonthpicker.dataSource = self
        secondmonthpicker.backgroundColor = UIColor.clear
        //secondmonthpicker.selectRow(0, inComponent: 0, animated: true)
        
        secondyearpicker = UIPickerView()
        secondyearpicker.delegate = self
        secondyearpicker.dataSource = self
        secondyearpicker.backgroundColor = UIColor.clear
        //secondyearpicker.selectRow(0, inComponent: 0, animated: true)
        
        ThirdcontainerView.addSubview(firstdaypicker)
        ThirdcontainerView.addSubview(firstmonthpicker)
        ThirdcontainerView.addSubview(firstyearpicker)
        
        ThirdcontainerView.addSubview(seconddaypicker)
        ThirdcontainerView.addSubview(secondmonthpicker)
        ThirdcontainerView.addSubview(secondyearpicker)
        
        //self.timeLabel.sizeToFit()
        ThirdcontainerView.addSubview(timeLabel)
        ThirdcontainerView.addConstraintsWithFormat("H:|[v0]-20-|", views: timeLabel)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.textColor = UIColor.gray
        label.sizeToFit()
        ThirdcontainerView.addSubview(label)
        //ThirdcontainerView.addConstraintsWithFormat("V:|[v0]|", views: label)
        
        ThirdcontainerView.addConstraintsWithFormat("H:|[v0(50)]-2-[v1(50)]-2-[v2(50)]", views: firstdaypicker, firstmonthpicker, firstyearpicker)
        ThirdcontainerView.addConstraintsWithFormat("H:[v0(50)]-2-[v1(50)]-2-[v2(50)]|", views: seconddaypicker, secondmonthpicker, secondyearpicker)
        
        ThirdcontainerView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: ThirdcontainerView, attribute: .top, multiplier: 1, constant: 0))
        ThirdcontainerView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: firstyearpicker, attribute: .right, multiplier: 1, constant: 0))
        ThirdcontainerView.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: seconddaypicker, attribute: .left, multiplier: 1, constant: 0))
        ThirdcontainerView.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: ThirdcontainerView, attribute: .bottom, multiplier: 1, constant: 20))
        
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: firstdaypicker, timeLabel)
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: firstmonthpicker, timeLabel)
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: firstyearpicker, timeLabel)
        
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: seconddaypicker, timeLabel)
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: secondmonthpicker, timeLabel)
        ThirdcontainerView.addConstraintsWithFormat("V:|[v0]-[v1(20)]|", views: secondyearpicker, timeLabel)
    }
    
    func createEventEndDate() -> Date
    {
        var dateComponents = DateComponents()
        
        let xfirstday = self.firstyearpicker.selectedRow(inComponent: 0)
        let xyolo = self.firstyearComponents[xfirstday]
        let nolo = "20\(xyolo)"
        let xstringfd = Int(nolo)
        //print("hello ",xstringfd)
        dateComponents.year = xstringfd
        
        let yfirstday = self.firstmonthpicker.selectedRow(inComponent: 0)
        let yyolo = self.firstmonthComponents[yfirstday]
        let ystringfd = Int(yyolo)
        dateComponents.month = ystringfd
        
        let firstday = self.firstdaypicker.selectedRow(inComponent: 0)
        let yolo = self.firstdayComponents[firstday]
        let stringfd = Int(yolo)!
        dateComponents.day = stringfd
        
        let xsecondday = self.seconddaypicker.selectedRow(inComponent: 0)
        let xyoloo = self.endtimehourComponents[xsecondday]
        let noloo = "\(xyoloo)"
        let xstringfdo = Int(noloo)
        dateComponents.hour = xstringfdo
        
        let ysecondday = self.secondmonthpicker.selectedRow(inComponent: 0)
        let yyoloo = self.endtimeminutesComponents[ysecondday]
        let ystringfdo = Int(yyoloo)
        dateComponents.minute = ystringfdo
        
        let secondday = self.secondyearpicker.selectedRow(inComponent: 0)
        let yoloo = self.endtimesecondsComponents[secondday]
        let stringfdo = Int(yoloo)!
        dateComponents.second = stringfdo
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let eventStartDate = userCalendar.date(from: dateComponents)
        
        return eventStartDate!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTextField.resignFirstResponder()
        
        self.descriptionTextView.resignFirstResponder()
    }
    
    @objc func placeNameTapped()
    {
        print("name tapped")
        let gg = GMSAutocompleteViewController()
        gg.delegate = self
        let navVC = UINavigationController(rootViewController: gg)
        
        self.present(navVC, animated: true) {
            
        }
    }
    
    func SelectedImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    @objc func ChooseImageButtonPressed()
    {
        print("Choose Image Button is clicked")
        let layout = UICollectionViewFlowLayout()
        let vc = PhotoSelectorController(collectionViewLayout: layout)
        vc.cameFromGatheringVC = true
        vc.delegate = self
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .overCurrentContext
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    @objc func CancelButtonPressed()
    {
        print("Cancel pressed")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func CheckIfAnythingsEmpty()
    {
        if self.imageView.image != nil && self.nameTextField.text != nil && self.CaptionLabel.text != nil
        {
            self.isAnythingEmpty = false
        }
        else
        {
            self.isAnythingEmpty = true
        }
    }
    
    @objc func PostButtonPressed()
    {
        print("Post pressed")
        self.CheckIfAnythingsEmpty()
        if self.isAnythingEmpty == false
        {
            let imageData = UIImagePNGRepresentation(self.imageView.image!)
            
            let imageFile = PFFile(name: "image.png", data: imageData!)
            
            let timeSelected = (self.firstdaypicker.selectedRow(inComponent: 0)) + 1
            
            print(timeSelected)
            
            //let startdate = self.createEventStartDate()
            let enddate = self.createEventEndDate()
                //let somepost = Gatcheck(nameGathering: self.nameTextField.text, venueName: self.placename, Gatheringdescription: self.descriptionTextView.text!, imageGathering: imageFile, startDate: startdate, endDate: enddate, xlocation: self.location, xUserWhoPosted: User.current())
                
                let gatheringPost = Gathering(nameGathering: self.nameTextField.text, venueName: self.placename, GatheringDescription: self.descriptionTextView.text!, imageGathering: imageFile, startDate: nil, endDate: enddate, xlocation: self.location, xUserWhoPosted: User.current())
                
                gatheringPost.saveInBackground { (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if error == nil
                    {
                        self.displayAlert("Gathering Created", message: "Your Gathering has been posted successfully")
                        //self.navigationController?.dismiss(animated: true, completion: nil)
                    }
                    else
                    {
                        print(error?.localizedDescription as Any)
                        self.displayAlert("Could not create Gathering", message: "Please try again later")
                    }
                }
            }
        else
        {
            self.displayAlert("Something is wrong", message: "Please enter all the details and check again")
        }
    }
    
    func displayAlert(_ title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.firstdaypicker
        {
            return 31
        }
        else if pickerView == self.firstmonthpicker
        {
            return 12
        }
        else if pickerView == self.firstyearpicker
        {
            return 2
        }
        if pickerView == self.seconddaypicker
        {
            return 23
        }
        else if pickerView == self.secondmonthpicker
        {
            return 59
        }
        else if pickerView == self.secondyearpicker
        {
            return 59
        }
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.firstdaypicker
        {
            return self.firstdayComponents[row]
        }
        else if pickerView == self.firstmonthpicker
        {
            return self.firstmonthComponents[row]
        }
        else if pickerView == self.firstyearpicker
        {
            return self.firstyearComponents[row]
        }
        
        if pickerView == self.seconddaypicker
        {
            return self.endtimehourComponents[row]
        }
        else if pickerView == self.secondmonthpicker
        {
            return self.endtimeminutesComponents[row]
        }
        else if pickerView == self.secondyearpicker
        {
            return self.endtimesecondsComponents[row]
        }
        return self.seconddayComponents[row]
    }
}

@available(iOS 9.0, *)
extension GatheringCreateVC: GMSAutocompleteViewControllerDelegate {
    /**
     * Called when a non-retryable error occurred when retrieving autocomplete predictions or place
     * details. A non-retryable error is defined as one that is unlikely to be fixed by immediately
     * retrying the operation.
     * <p>
     * Only the following values of |GMSPlacesErrorCode| are retryable:
     * <ul>
     * <li>kGMSPlacesNetworkError
     * <li>kGMSPlacesServerError
     * <li>kGMSPlacesInternalError
     * </ul>
     * All other error codes are non-retryable.
     * @param viewController The |GMSAutocompleteViewController| that generated the event.
     * @param error The |NSError| that was returned.
     */
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        //            let vc = CheckInPostVC()
        //            self.navigationController?.pushViewController(vc, animated: true)
        
        return true
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        //
        print("Error: ", error.localizedDescription)
    }
    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress as Any)
        print("Place attributions: ", place.attributions as Any)
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        
        self.placename = place.name
        
        
        self.xplace = place
        let xcurrentLoc = PFGeoPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let status = "\(place.name)"
        
        //            let xPost = Post(shares: status, userID: PFUser.current()!.objectId!, xImageFile: nil, numberOfLikes: 0, xlocation: xcurrentLoc, xUserWhoPosted: User.current(), numberOfComments: 0, isALocation: true, locationName: placename, numberIfLocation: 1, numberIfStatus: 0, numberIfPhoto: 0, numberIfCheckIn: 1)
        //            xPost.saveInBackground { (success, error) -> Void in
        //                if error == nil
        //                {
        //                    print("location post saved successfully")
        //                }
        //                else
        //                {
        //                    print(error?.localizedDescription as Any)
        //                }
        //            }
        
        //        let vc = CheckInPostVC()
        //        vc.CaptionLabel.text = status
        //navigationController?.pushViewController(vc, animated: true)
        
        self.location = xcurrentLoc
        
        self.CaptionLabel.textColor = UIColor.black
        self.CaptionLabel.text = status
        
        //self.queryObjects()
        self.dismiss(animated: true, completion: nil)
    }
    
    /*func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
     // TODO: handle the error.
     //print("Error: ", error.description)
     }*/
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
