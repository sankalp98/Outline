//
//  CheckInMapsCell.swift
//  Outline
//
//  Created by Apple on 30/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import IGListKit
import Parse
import GoogleMaps

class CheckInMapsCell: UICollectionViewCell
{
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    var CaptionLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        //label.backgroundColor = UIColor.yellow
        return label
    }()
    
    var isMapShown = false
    
    var MapContainerView = UIView()
    
    var location : PFGeoPoint!
    
    var xplace : GMSPlace!
    
    var camera: GMSCameraPosition!
    
    var mapView: GMSMapView!
    
    var currentLoc: CLLocationCoordinate2D!
    
    var marker: GMSMarker!
    
    func updateUI()
    {
        self.location = post.location
        self.camera = GMSCameraPosition.camera(withLatitude: self.location.latitude, longitude: self.location.longitude, zoom: 13)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        
        addConstraintsWithFormat("H:|-0-[v0]-0-|", views: mapView)
        addConstraintsWithFormat("V:|-0-[v0]-0-|", views: mapView)
        
        self.currentLoc = CLLocationCoordinate2D(latitude: self.location.latitude, longitude: self.location.longitude)
        self.marker = GMSMarker(position: currentLoc)
        marker.title = self.post.shares
        marker.map = mapView
        
    }
}
