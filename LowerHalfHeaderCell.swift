//
//  LowerHalfHeaderCell.swift
//  Outline
//
//  Created by Apple on 06/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse

class StatusCell: UICollectionViewCell
{
    var user: User! {
        didSet {
            self.updateUI()
        }
    }
    
    var CaptionLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //ontentView.layer.addSublayer(separator)
        //contentView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        if (self.user.Status) != nil
        {
            let someText = self.user.Status
            let attributedString = NSAttributedString(string: "\(someText!)", attributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size:13)!])
            CaptionLabel.attributedText = attributedString
        }
        
        //CaptionLabel.sizeToFit()
        
        CaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(CaptionLabel)
        
        addConstraintsWithFormat("H:|-3-[v0]-3-|", views: CaptionLabel)
        addConstraintsWithFormat("V:|-0-[v0]-0-|", views: CaptionLabel)
        
        //separator.frame = CGRect(x: 10, y: self.frame.height, width: contentView.bounds.width - 20, height: 0.5)
        
    }
}
