//
//  MapViewController.swift
//  foodbowl-ios
//
//  Created by Tech on 2021-04-16.
//  Copyright © 2021 GBC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

     var address: String!;
     var city:String!;
    var province: String!;
    @IBOutlet var map: MKMapView!;
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.delegate = self
        getAddress()        // Do any additional setup after loading the view.
    }
    
    func getAddress(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address + ", " + city + ", " + province!){(placemarks, error)
            in
            guard let placemarks = placemarks, let location =
                placemarks.first?.location
                else{
                    print("location not found")
                    return
            }
            self.maptoRestaurant(destinationCoord: location.coordinate)
            
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
    }
    
    func maptoRestaurant(destinationCoord: CLLocationCoordinate2D){
        
        let ourLocation = (locationManager.location?.coordinate)!
        let ourPlaceMark = MKPlacemark(coordinate: ourLocation)
        let destPlaceMark = MKPlacemark(coordinate: destinationCoord)
        let ourMark = MKMapItem(placemark: ourPlaceMark)
        let destMark = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = ourMark
        destinationRequest.destination = destMark
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate{(response, error) in
            guard let response = response else {
                if let error = error {
                    print("error by mkDirections")
                }
                return
            }
            //Make map overlay visible
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
     
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .red
        return render;
    }
    /*
    // MARK: - Navigation
     //stuff from tuttt
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
