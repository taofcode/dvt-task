//
//  HomePageViewController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

public class HomePageViewController: UIViewController, CLLocationManagerDelegate {

var locationManager = CLLocationManager()
    


}
extension HomePageViewController{
    public override func loadView() {
        
        let city :String = "Harare";
        let key : String = BackEndInfo.API_KEY_EIGHT
        
        API.requestCurrentCityWeather(city, key: key ) { (resultTransaction) -> Void in
            
            resultTransaction.success({ (transactionModel) -> Void in
                
                
            })
            
        }
    }
    
    public override func viewDidLoad() {
        
       
  //      http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1
    }

    public func locationStatusCheck(locationactived: Bool = false) -> Bool{
        viewWillAppear(true)
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                  
                }
            }
            if locationManager.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization)){
                locationManager.requestWhenInUseAuthorization()
            }
            else{
                locationManager.startUpdatingLocation()
            }
            return true
            
        }
        else {
            
            
            
                let alertController = UIAlertController(title:"Error", message: "It appears your location service is turned off for this app. Please activate to continue", preferredStyle: .ActionSheet)
                let acceptButton = UIAlertAction(title: "Activate Location Service", style: .Default, handler: {(action) -> Void in
                    if let url = NSURL(string:"App-Prefs:root=Privacy&path=LOCATION") {
                        UIApplication.sharedApplication().openURL(url)
                        
                    }
                })
                let cancelButton = UIAlertAction(title: "Return", style: .Cancel, handler: nil)
                
                alertController.addAction(acceptButton)
                alertController.addAction(cancelButton)
                self.presentViewController(alertController, animated: true, completion: nil)
            
            }
            
            
            return false
        }
        
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("Error to update location :%@",error)
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .NotDetermined: break
        case .Restricted: break
        case .Denied:
          
            break
        default:
            
            manager.startUpdatingLocation()
          
       
        }
    }
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        
    }
    
    func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability.reachabilityForInternetConnection()
            let networkStatus: Int = reachability.currentReachabilityStatus.hashValue
            
            return (networkStatus != 0)
        }
        catch {
            // Handle error
            return false
        }
    }



