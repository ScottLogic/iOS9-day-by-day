//
//  Destination.swift
//  MapKitTransit
//
//  Created by Chris Grant on 09/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import Foundation
import MapKit

class Destination {
    
    let coordinate:CLLocationCoordinate2D
    private var addressDictionary:[String : AnyObject]
    let name:String
    
    init(withName placeName: String,
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        address:[String:AnyObject])
    {
        name = placeName
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        addressDictionary = address
    }
    
    var mapItem:MKMapItem {
        get {
            let placemark = MKPlacemark(
                coordinate: self.coordinate,
                addressDictionary: self.addressDictionary)
            
            let item = MKMapItem(placemark: placemark)
            return item
        }
    }
}
