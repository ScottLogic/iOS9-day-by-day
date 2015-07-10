//
//  ViewController.swift
//  MapKitTransit
//
//  Created by Chris Grant on 09/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ViewController: UIViewController, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    var destinations:[Destination]
    
    var userAnnotation:MKPointAnnotation?
    var userCoordinate:CLLocationCoordinate2D?
    
    required init?(coder aDecoder: NSCoder) {
        
        let stPauls = Destination(withName: "St Paul's Cathedral", latitude: 51.5138244, longitude: -0.0983483,
            address: [
                CNPostalAddressStreetKey:"St. Paul's Churchyard",
                CNPostalAddressCityKey:"London",
                CNPostalAddressPostalCodeKey:"EC4M 8AD",
                CNPostalAddressCountryKey:"England"])
        
        let towerBridge = Destination(withName: "Tower Bridge", latitude: 51.5054644, longitude: -0.0754688,
            address: [
                CNPostalAddressStreetKey:"Tower Bridge Rd",
                CNPostalAddressCityKey:"London",
                CNPostalAddressPostalCodeKey:"SE1 2UP",
                CNPostalAddressCountryKey:"England"])
        
        let buckinghamPalace = Destination(withName: "Buckingham Palace", latitude: 51.5015639, longitude: -0.141328,
            address: [
                CNPostalAddressStreetKey:"Buckingham Palace",
                CNPostalAddressCityKey:"London",
                CNPostalAddressPostalCodeKey:"SW1A 1AA",
                CNPostalAddressCountryKey:"England"])
        
        destinations = [stPauls, towerBridge, buckinghamPalace]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        mapView.addGestureRecognizer(tap)
        
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(51.5074157),
                longitude: CLLocationDegrees(-0.1201011)),
            span: MKCoordinateSpan(
                latitudeDelta: CLLocationDegrees(0.025),
                longitudeDelta: CLLocationDegrees(0.025)))
        
        for destination in destinations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = destination.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func handleTap(gestureRecognizer:UITapGestureRecognizer) {
        let point = gestureRecognizer.locationInView(mapView)
        
        userCoordinate = mapView.convertPoint(point, toCoordinateFromView:mapView)
        
        if userAnnotation != nil {
            mapView.removeAnnotation(userAnnotation!)
        }
        
        userAnnotation = MKPointAnnotation()
        userAnnotation!.coordinate = userCoordinate!
        mapView.addAnnotation(userAnnotation!)
        
        for cell in self.tableView.visibleCells as! [DestinationTableViewCell] {
            cell.userCoordinate = userCoordinate
        }
    }
}

extension ViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("destinationCell") as! DestinationTableViewCell
        cell.destination = destinations[indexPath.row]
        cell.userCoordinate = userCoordinate
        return cell
    }
    
}

extension ViewController {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.pinTintColor = annotation === userAnnotation ? UIColor.redColor() : UIColor.blueColor()
        return pin
    }
}
