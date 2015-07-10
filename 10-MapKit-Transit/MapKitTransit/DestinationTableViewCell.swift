//
//  DestinationTableViewCell.swift
//  MapKitTransit
//
//  Created by Chris Grant on 09/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import MapKit

class DestinationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var destination:Destination? {
        didSet {
            nameLabel.text = destination!.name
        }
    }
    
    var userCoordinate:CLLocationCoordinate2D? {
        didSet {
            
            etaLabel.text = ""
            departureTimeLabel.text = "Departure Time:"
            arrivalTimeLabel.text = "Arrival Time:"
            distanceLabel.text = "Distance:"
            
            guard let coordinate = userCoordinate else { return }
            
            let request = MKDirectionsRequest()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            request.destination = destination!.mapItem
            request.transportType = .Transit
            let directions = MKDirections(request: request)
            directions.calculateETAWithCompletionHandler { response, error -> Void in
                if let err = error {
                    print(err)
                    self.etaLabel.text = err.userInfo["NSLocalizedFailureReason"] as? String
                    return
                }
                
                let nf = NSNumberFormatter()
                nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
                nf.maximumFractionDigits = 0
                
                self.etaLabel.text = "\(nf.stringFromNumber(response!.expectedTravelTime/60)!) minutes travel time"
                self.departureTimeLabel.text = "Departure Time: \(response!.expectedDepartureDate)"
                self.arrivalTimeLabel.text = "Arrival Time: \(response!.expectedArrivalDate)"
                self.distanceLabel.text = "Distance: \(response!.distance) meters"
            }

        }
    }
    
    @IBAction func viewRouteTapped(sender: UIButton) {
        guard let mapDestination = destination else { return }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapDestination.mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
}
