//
//  MapViewController.swift
//  CityLocatorApplication
//
//  Created by Suresh on 02/12/14.
//  Copyright (c) 2014 Neev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var cityName: String! = nil
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var locationManager : CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.frame = CGRectMake(0, 0, 100, 100)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        self.title = "City Location"
        self.locationManager.delegate = self;
        self.locationManager.requestWhenInUseAuthorization()
      self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var reachabilityStatus = Reachability.reachabilityForInternetConnection().currentReachabilityStatus().value
        if(reachabilityStatus == 0) {
            println("Network unavailable")
            var alerViewController : UIAlertController = UIAlertController(title: "Network Unavailable", message: "Find a source to connect with Network", preferredStyle: UIAlertControllerStyle.Alert)
            var alertAction : UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alerViewController.addAction(alertAction)
            self.presentViewController(alerViewController, animated: true, completion: nil)
        }
        else {
            println("Network Available")
            var geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(self.cityName, completionHandler: {( placemarks : [AnyObject]!, error : NSError!) in
                if let topResult = placemarks?[0] as? CLPlacemark {
                    var placemark : MKPlacemark! = MKPlacemark(placemark: topResult)
                    var region = self.mapView.region
                    region.center = ((placemark.region) as CLCircularRegion).center
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self.mapView.setRegion(region, animated: true)
                    self.mapView.addAnnotation(placemark)
                }
            })

        }
       
//        self.mapView.addAnnotation(myLocation)
        self.mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var cityDetailViewController = storyBoard.instantiateViewControllerWithIdentifier("cityDetailViewController") as CityDetailViewController
        cityDetailViewController.cityUrlString = "http://en.wikipedia.org/wiki/\(self.cityName)"
        println("selected annotation address : \(view.annotation.description)")
        self.navigationController?.pushViewController(cityDetailViewController, animated: true)
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 2
        if status == .AuthorizedWhenInUse {
            
        }
        var myLocation  = self.mapView.userLocation.coordinate
        
        println("myLocation \(myLocation.latitude), \(myLocation.longitude)")
    }
   
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        println("inside update locations\(location)")
        self.locationManager.stopUpdatingLocation()
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapViewWillStartRenderingMap(mapView: MKMapView!) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    func mapViewDidFinishRenderingMap(mapView: MKMapView!, fullyRendered: Bool) {
        activityIndicator.stopAnimating()
    }
}
