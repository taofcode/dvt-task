//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Shelton on 10/22/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit
import CoreLocation


final public class MainViewController: UINavigationController, CLLocationManagerDelegate{
    var dateLabel = UILabel()
    var labelMaxTemp = UILabel()
    var labelMinTemp = UILabel()
    var labelLocale = UILabel()
    var labelImageView  =  UIImageView()
    var locationManager = CLLocationManager()
    var  locale : String?
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.color(.backgroundColor)
        
       
        let key : String = BackEndInfo.API_KEY_MAIN
       
       
        API.requestCurrentCityWeather((locationManager.location?.coordinate.latitude.description)!,lon: (locationManager.location?.coordinate.longitude.description)!, key: key ) { (resultTransaction) -> Void in
            
            resultTransaction.success({ (transactionModel) -> Void in
                let date = NSDate()
                let formatter = NSDateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                  let currentDate = formatter.stringFromDate(date)
                  self.dateLabel.text = currentDate
                  self.labelMaxTemp.text =  transactionModel.main.temp_max!.description
                  self.labelMinTemp.text = transactionModel.main.temp_min?.description
                  let currentLocale = NSLocale.currentLocale()
                  let country =   currentLocale.localizedStringForCountryCode(transactionModel.sys.country!)
                  self.labelLocale.text = "\(transactionModel.name!) , \(country)"
                   
                
            }).failure({ (error) -> Void in
                
                let errorAlert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .Alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)
            })
            
            
        }
    }
    
    
    
}
extension MainViewController{
 

    public func locationStatusCheck(locationactived: Bool = false) -> Bool{
        viewWillAppear(true)
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
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
            let alertController = UIAlertController(title:"Branch Locator", message: "It appears your location service is turned off for this app. Please activate to continue", preferredStyle: .ActionSheet)
            let acceptButton = UIAlertAction(title: "Activate Location Service", style: .Default, handler: {(action) -> Void in
                if let url = NSURL(string:"App-Prefs:root=Privacy&path=LOCATION") {
                    UIApplication.sharedApplication().openURL(url)
                    
                }
            })
            let cancelButton = UIAlertAction(title: "Go Back", style: .Cancel, handler: nil)
            
            alertController.addAction(acceptButton)
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
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
            NSLog("do some error handling")
            break
        default:
            locationManager.startUpdatingLocation()
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




    func didPressRefreshButton(sender:AnyObject){}


}

