//
//  5.swift
//  Outline
//
//  Created by Apple on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit

class DateCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    var DateLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        //label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).cgColor
        return layer
    }()
    
    var TimeOfPostParse: Date = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)
        //contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        //self.backgroundColor = UIColor.yellow
        
        self.addSubview(DateLabel)
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.TimeOfPostParse = post.createdAt!
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM, dd"
        let xdateString = dayTimePeriodFormatter.string(from: self.TimeOfPostParse)
        self.DateLabel.text = "\(xdateString)"
        DateLabel.font = UIFont(name: "HelveticaNeue", size: 11)
        DateLabel.textColor = UIColor.lightGray
        DateLabel.textAlignment = NSTextAlignment.right
        DateLabel.sizeToFit()
        addConstraintsWithFormat("H:|-10-[v0]", views: DateLabel)
        addConstraintsWithFormat("V:|-2-[v0]-2-|", views: DateLabel)
        
        separator.frame = CGRect(x: 10, y: self.frame.height, width: contentView.bounds.width - 20, height: 0.5)
        
    }
}
