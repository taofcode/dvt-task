//

//  MainViewController.swift

//  WeatherApplication

//

//  Created by Shelton on 10/22/17.

//  Copyright © 2017 ThundrCraft. All rights reserved.

//



import UIKit
import MBProgressHUD
import CoreLocation

final public class MainViewController: UIViewController, CLLocationManagerDelegate{
    var dateLabel = UITextField()
    
    var labelMaxTemp = UILabel()
    
    var labelMinTemp = UILabel()
    
    var labelLocale = UILabel()
    
    var imageView  =  UIImageView()
    var image = UIImage()
    
    var locationManager = CLLocationManager()
    var  locale : String?
    
    let key : String = BackEndInfo.API_KEY_MAIN
    public override func loadView() {
        
        super.loadView()
        
            dateLabel.textColor = Theme.current.color(.buttonTextColorSecondary)
            dateLabel.font = .systemFontOfSize(17)
            dateLabel.textAlignment = .Center
            view.addSubview(dateLabel)
        
        labelMinTemp.textColor = Theme.current.color(.buttonTextColorSecondary)
        labelMinTemp.textAlignment = .Center
        labelMinTemp.font = .systemFontOfSize(15.0)
        
        view.addSubview(labelMinTemp)
        
         labelMaxTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                labelMaxTemp.textColor = Theme.current.color(.buttonTextColorSecondary)
                 labelMaxTemp.textAlignment = .Center
                view.addSubview(labelMaxTemp)
        
               labelLocale.textColor = Theme.current.color(.textFieldBorderColor)
                labelLocale.font = UIFont.boldSystemFontOfSize(12)
        
                view.addSubview(labelLocale)
        
                imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
                view.addSubview(imageView)
        
                setupLayoutConstraints()
        
        
        
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.color(.backgroundColor)
        
        
        self.navigationItem.title = "Weather"
    
        
        
        let stopButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: #selector(MainViewController.didPressCloseButton(_:)))
        navigationItem.rightBarButtonItem = stopButton
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .Plain, target: self, action: #selector(MainViewController.didPressRefreshButton(_:)))
        navigationItem.leftBarButtonItem = refreshButton
        if hasConnectivity() == true {
            
            requestWeather()
            
        }
            
        else{
            
            let alertController = UIAlertController(title:"Weather", message: "It appears your internet connection is not available at the moment. Please check your connection and try again", preferredStyle: .ActionSheet)
            
            let cancelButton = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelButton)
            let popOver = alertController.popoverPresentationController
            popOver?.sourceView = self.view
            popOver?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popOver?.permittedArrowDirections = UIPopoverArrowDirection.Down
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
    }
        func requestWeather() {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            if(locationManager.location != nil){
        API.requestCurrentCityWeather((locationManager.location?.coordinate.latitude.description)!,lon: (locationManager.location?.coordinate.longitude.description)!, key: key ) { (resultTransaction) -> Void in
            resultTransaction.success({ (transactionModel) -> Void in
                
                let date = NSDate()
                
                let formatter = NSDateFormatter()
                
                formatter.dateFormat = "dd MMMM yyyy"
                
                let currentDate = formatter.stringFromDate(date)
                
                self.dateLabel.text = "TODAY, " + currentDate
                
                self.labelMaxTemp.text =  String(format: "max %.0f\u{00B0}\u{0043}", transactionModel.main.temp_max! - 273.15 )
                
                self.labelMinTemp.text = String(format: "min %.0f\u{00B0}\u{0043}", transactionModel.main.temp_min!  - 273.15 )
                
                let currentLocale = NSLocale.currentLocale()
                
                let country =   currentLocale.localizedStringForCountryCode(transactionModel.sys.country!)
                
                self.labelLocale.text = " \(transactionModel.name!), "+country!
                
                self.imageView.image = self.resizeImage(UIImage(named: transactionModel.weather[0].icon!)!,newWidth: 70.00)
                
                
                
            }).failure({ (error) -> Void in
                
                
                
                let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                
                let popOver = errorAlert.popoverPresentationController
                
                popOver?.sourceView = self.view
                
                popOver?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                
                popOver?.permittedArrowDirections = UIPopoverArrowDirection.Down
                
                
                
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
            })
            
            
            
            
            
        }
            hud.hide(true)
            }
            else{
            
             hud.hide(true)
                let alertController = UIAlertController(title:"Cool Weather", message: "It appears your location service is turned off for this app. Please activate to continue", preferredStyle: .ActionSheet)
                
                let acceptButton = UIAlertAction(title: "Activate Location Service", style: .Default, handler: {(action) -> Void in
                    
                    if let url = NSURL(string:"App-Prefs:root=Privacy&path=LOCATION") {
                        
                        UIApplication.sharedApplication().openURL(url)
                           exit(0)
                        
                        
                    }
                    
                })
                
                let cancelButton = UIAlertAction(title: "Go Back", style: .Cancel, handler:  {(action) -> Void in
                    
                    exit(0)
                    
                })
                alertController.addAction(acceptButton)
                
                alertController.addAction(cancelButton)
                
                let popOver = alertController.popoverPresentationController
                
                popOver?.sourceView = self.view
                
                popOver?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popOver?.permittedArrowDirections = UIPopoverArrowDirection.Down
                self.presentViewController(alertController, animated: true, completion: nil)
                


            
            }
    }
    
}

extension MainViewController{
    
    
    
    struct Layout {
        
        static let spacing = 60
        static let spacingMargin = 75
        static let padding = 5
    }


    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    private func setupLayoutConstraints() {
        
        dateLabel.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view)
            
            make.top.equalTo(view).offset(Layout.spacing)
            
        }
        
        imageView.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view)
            
            make.left.equalTo(view).offset(Layout.spacing)
            
            make.top.equalTo(dateLabel.snp_bottom).offset(Layout.spacing/2)
            
        }
        
        
        
        
        
        labelMaxTemp.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view)
            
            make.left.equalTo(view).offset(Layout.spacing)
            
            make.top.equalTo(imageView.snp_bottom).offset(Layout.spacing/2)
            
        }
        
        
        
        labelMinTemp.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view)
            
            make.left.equalTo(view).offset(Layout.spacing)
            
            make.top.equalTo(labelMaxTemp.snp_bottom).offset(Layout.padding)
            
        }
        
        
        
        labelLocale.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(view)
            
            make.left.equalTo(view).offset(Layout.spacingMargin)
            
            make.top.equalTo(labelMinTemp.snp_bottom).offset(Layout.spacing/2)
            
        }
        
        
        
        
        
        
        
        
        
    }
    
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
            
            let alertController = UIAlertController(title:"Cool Weather", message: "It appears your location service is turned off for this app. Please activate to continue", preferredStyle: .ActionSheet)
            
            let acceptButton = UIAlertAction(title: "Activate Location Service", style: .Default, handler: {(action) -> Void in
                
                if let url = NSURL(string:"App-Prefs:root=Privacy&path=LOCATION") {
                    
                    UIApplication.sharedApplication().openURL(url)
                    
                    
                    
                }
                
            })
            
            let cancelButton = UIAlertAction(title: "Go Back", style: .Cancel, handler:  {(action) -> Void in
                
            exit(0)
                
            })
            
            alertController.addAction(acceptButton)
            
            alertController.addAction(cancelButton)
            
            let popOver = alertController.popoverPresentationController
            
            popOver?.sourceView = self.view
            
            popOver?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popOver?.permittedArrowDirections = UIPopoverArrowDirection.Down
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
    func didPressCloseButton(sender:AnyObject){
        
            exit(0)
    }
    func didPressRefreshButton(sender:AnyObject){
        
        requestWeather()
        
    }
    
    
    
    
    
}

