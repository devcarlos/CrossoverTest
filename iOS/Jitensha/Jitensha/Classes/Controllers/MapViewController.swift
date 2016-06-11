//
//  MapViewController.swift
//  Jitensha
//
//  Created by Carlos Alcala on 6/9/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class MapViewController: UIViewController {

    //MARK : IBOutlets
    
    @IBOutlet weak var mapViewContainer: UIView!
    
    //MARK : Properties
    
    var request: Request?
    
    var mapView: GMSMapView = GMSMapView()
    
    let path = GMSMutablePath()
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //configure the Map
        self.configureMap()
        
        //load API data
        self.loadMapData()
    }
    
    deinit {
        request?.cancel()
    }
    
    //MARK : Map Functions
    
    func configureMap() {
        
        let camera = GMSCameraPosition.cameraWithLatitude(35.7090259,
                                                          longitude: 139.7319925, zoom: 12)
        mapView = GMSMapView.mapWithFrame(self.view.bounds, camera: camera)
        mapView.myLocationEnabled = true
        self.mapViewContainer.addSubview(mapView)
    }
    
    //MARK : API Call Functions
    
    func loadMapData() {
        request = APIManager.sharedInstance.getPlaces { [unowned self]
            (places, error) in
            
            self.request = nil
            
            if let errorValid = error {
                let alert = ErrorManager.errorAlertController(errorValid)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                
                print("PLACES: \(places.count)")
                
                //iterate and display places on map
                for place in places {
                    print("ID: \(place.id)")
                    print("NAME: \(place.name)")
                    print("LAT: \(place.lat)")
                    print("LNG: \(place.lng)")
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(place.lat, place.lng)
                    marker.title = place.name
                    marker.map = self.mapView
                    
                    self.path.addCoordinate(CLLocationCoordinate2DMake(place.lat, place.lng))
                    
                    let bounds = GMSCoordinateBounds(path: self.path)
                    self.mapView.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds, withPadding: 50.0))
                    
                }
            }
        }
    }
    
    //MARK : Actions
    
    @IBAction func logoutAction(sender: AnyObject) {
        self.logout()
    }
    
    func logout() {
        
        //show alert message and continue to Home
        self.showConfirmAlert("Logout Confirmation", message: "Do you really want to Logout?", handler:  { (action) in
            //remove token from user defaults
            NSUserDefaults.standardUserDefaults().removeObjectForKey("accessToken")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //back to Login View
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
