//
//  2.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

class PostImageCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    //var postLabel = UILabel()
    var postimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return imageView
    }()
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(activityView)
        contentView.addSubview(postimageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        let bounds = contentView.bounds
        activityView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        postimageView.frame = bounds
        
        
        //let width = UIScreen.main.bounds.width
        
        //postimageView.translatesAutoresizingMaskIntoConstraints = false
        //postimageView.image = UIImage(named: "my")
        contentView.addSubview(postimageView)
        contentView.addSubview(activityView)
        
        //addConstraintsWithFormat("H:|[v0]|", views: postimageView)
        //addConstraintsWithFormat("V:|[v0]|", views: postimageView)
        
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
