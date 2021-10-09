//
//  OutineStatusImageCell.swift
//  Outline
//
//  Created by Apple on 30/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

protocol StatusImageCellExpandedDelegator {
    func ImageCellExpanded(_ isCellExpanded: Bool)
}

class StatusImageCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    var delegate: StatusImageCellExpandedDelegator!
    
    //var postLabel = UILabel()
    var postimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        return imageView
    }()
    
    var blurEffect = UIBlurEffect()
    var blurredEffectView = UIVisualEffectView()
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    var isCellExpanded = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.addSubview(activityView)
        //contentView.addSubview(postimageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        //let bounds = contentView.bounds
        //activityView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        //postimageView.frame = bounds
        
        self.addSubview(activityView)
        self.addSubview(postimageView)
        postimageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.ImageTapped))
        postimageView.addGestureRecognizer(tapGesture)
        
        
        //let width = UIScreen.main.bounds.width
        
        postimageView.translatesAutoresizingMaskIntoConstraints = false
        //postimageView.image = UIImage(named: "my")
        //contentView.addSubview(postimageView)
        //contentView.addSubview(activityView)
        
        addConstraintsWithFormat("H:|[v0]|", views: activityView)
        addConstraintsWithFormat("V:|[v0]|", views: activityView)
        
        addConstraintsWithFormat("H:|[v0]|", views: postimageView)
        addConstraintsWithFormat("V:|[v0]|", views: postimageView)
        
        //self.blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
//        self.blurEffect = UIBlurEffect(style: .regular)
//        self.blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        //blurredEffectView.frame = postimageView.bounds
//        postimageView.addSubview(blurredEffectView)
//        addConstraintsWithFormat("H:|[v0]|", views: blurredEffectView)
//        addConstraintsWithFormat("V:|[v0]|", views: blurredEffectView)
        
        if post.ImageFiles != nil
        {
            postimageView.file = self.post.ImageFiles
            
            self.postimageView.load(inBackground: { (image, error) in
                self.activityView.stopAnimating()
                self.activityView.removeFromSuperview()
            }, progressBlock: { (number) in
                print(number)
            })
        }
        
    }
    
    @objc func ImageTapped()
    {
        if isCellExpanded == false
        {
            self.delegate.ImageCellExpanded(true)
            isCellExpanded = true
            print("Imagetapped")
            UIView.animate(withDuration: 0.5, animations: { 
                //self.blurredEffectView.alpha = 0
                //self.blurredEffectView.effect = nil
            })
            //self.blurredEffectView.alpha = 0
        }
        else
        {
            self.delegate.ImageCellExpanded(false)
            isCellExpanded = false
            print("Imagetapped")
            UIView.animate(withDuration: 0.5, animations: {
                //self.blurredEffectView = UIVisualEffectView(effect: self.blurEffect)
            })
        }
    }
    
    func setImage(image: UIImage?) {
        postimageView.image = image
        if image != nil {
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        } else {
            activityView.startAnimating()
        }
    }
}
