//
//  TryingStacked.swift
//  Outline
//
//  Created by Apple on 15/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import IGListKit

final class HorizontalSectionController: ListSectionController, ListAdapterDataSource {
    
    private var number: Int?
    var arrayOfGatherings = [Gathering]()
    
    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                    viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: EmbeddedCollectionViewCell.self, for: self, at: index) as! EmbeddedCollectionViewCell
        adapter.collectionView = cell.collectionView
        return cell
    }
    
    override func didUpdate(to object: Any) {
        number = object as? Int
    }
    
    //MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.arrayOfGatherings
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EmbeddedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

final class EmbeddedCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.frame
    }
    
}

final class EmbeddedSectionController: ListSectionController, GatheringImageClickedDelegator {
    
    private var number: Int?
    var GatheringObject: Gathering!
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: height, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as! CenterLabelCell
        cell.gathering = self.GatheringObject
        //let value = number ?? 0
        cell.text = ""
        cell.delegate = self
        //cell.backgroundColor = UIColor(red: 237/255.0, green: 73/255.0, blue: 86/255.0, alpha: 1)
       // cell.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        //number = object as? Int
        let ola = object as! Gathering
        self.GatheringObject = ola
    }
    
    func GoToGatheringVC(_ gathering: Gathering)
    {
        let vc = GatheringVC()
        //vc.view.backgroundColor = UIColor.white
        vc.gathering = gathering
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

import UIKit

protocol GatheringImageClickedDelegator
{
    func GoToGatheringVC(_ gathering: Gathering)
}

final class CenterLabelCell: UICollectionViewCell {
    
    lazy private var label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.textColor = .white
        //view.layer.cornerRadius = 25
        view.font = .boldSystemFont(ofSize: 18)
        self.contentView.addSubview(view)
        return view
    }()
    
    var gathering: Gathering! {
        didSet {
            self.updateUI()
        }
    }
    
    var delegate: GatheringImageClickedDelegator!
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    var postimageView: PFImageView = {
        let imageView = PFImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.layer.cornerRadius = 25
        self.addSubview(postimageView)
        self.addSubview(activityView)
    }
    
    
    var tpgesture: UITapGestureRecognizer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI()
    {
        let bounds = contentView.bounds
        activityView.center = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        postimageView.frame = bounds
        
        self.tpgesture = UITapGestureRecognizer(target: self, action: #selector(self.gatheringImageTapped))
        tpgesture.numberOfTapsRequired = 1
        postimageView.isUserInteractionEnabled = true
        postimageView.addGestureRecognizer(tpgesture)
        
        //let width = UIScreen.main.bounds.width
        
        //postimageView.translatesAutoresizingMaskIntoConstraints = false
        //postimageView.image = UIImage(named: "my")
//        contentView.addSubview(postimageView)
//        contentView.addSubview(activityView)
        
        //addConstraintsWithFormat("H:|[v0]|", views: postimageView)
        //addConstraintsWithFormat("V:|[v0]|", views: postimageView)
        
        print(self.gathering.nameGathering)
        
        if self.gathering.imageGathering != nil
        {
            postimageView.file = self.gathering.imageGathering
            
            self.postimageView.load(inBackground: { (image, error) in
                self.activityView.stopAnimating()
                self.activityView.removeFromSuperview()
            }, progressBlock: { (number) in
                print(number)
            })
        }
        
    }
    
    @objc func gatheringImageTapped()
    {
        print("Image tapped")
        self.delegate.GoToGatheringVC(self.gathering)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
    
}
