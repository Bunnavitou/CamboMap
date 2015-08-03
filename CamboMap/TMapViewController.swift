//
//  TMapViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/29/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//


import UIKit

enum TravelModes: Int {
    case driving
    case walking
    case bicycling
}

class TMapViewController: YomanViewController ,  CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate{

    @IBOutlet var viewMap: GMSMapView!
    
    @IBOutlet var toolbarMenu: UIToolbar!
    
    @IBOutlet var mainTableView: UITableView!
    
    @IBOutlet var mainTableViewHeightConstraint: NSLayoutConstraint!
    
    
    var placePicker: GMSPlacePicker?

    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var mapTasks = MapTasks()
    var locationMarker: GMSMarker!

    //=======For Check
    var checkMoveMap = false
    
    lazy var searchBarDisplay : UISearchBar = {
        var searchBar   = UISearchBar()
        searchBar.frame = CGRectMake(0, 0, self.mainTableView.frame.size.width, 44.0)
        searchBar.delegate          = self
        searchBar.tintColor         = UIColor(red: 0 / 255, green: 154 / 255, blue: 255 / 255, alpha: 1.0)
        searchBar.barTintColor      = UIColor(red: 0 / 255, green: 154 / 255, blue: 255 / 255, alpha: 1.0)
    
        
//        [UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor redColor]];
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.hidden = true
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(11.558363, longitude: 104.911911, zoom: 10.0)
        viewMap.camera = camera
        viewMap.settings.compassButton    = true
        viewMap.delegate = self
    
        
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden  = true
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
            viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
            viewMap.settings.myLocationButton = true
            didFindMyLocation = true
            
        }
    }
    
    // MARK: - GMSMapViewDelegate method implementation -
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        
        if checkMoveMap {
            viewMap.settings.myLocationButton = false
        }else{
            viewMap.settings.myLocationButton = true
        }
        
    }
    func mapView(mapView: GMSMapView!, willMove gesture: Bool){
        if(toolbarMenu.hidden) {
            clearMethod()
        }
        
        
    }
    
    // MARK:  - CLLocationManagerDelegate method implementation -
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            viewMap.myLocationEnabled = true
        }
    }
    
    // MARK: - UITableView Method Area
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 10
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return searchBarDisplay
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier) as UITableViewCell
        }
        
        cell!.textLabel?.font        = UIFont.systemFontOfSize(15)
        cell!.textLabel?.textColor   = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
        cell!.detailTextLabel?.font  = UIFont.systemFontOfSize(12)
        cell!.detailTextLabel?.textColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1)
        
        cell?.textLabel?.text="YOMAN"
        
        
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
      

        
    }
    
    // MARK: - UISearchBar Method Area -
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        
        mainTableViewHeightConstraint.constant = 3 * 44;
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar){

        self.mapTasks.geocodeAddress(searchBar.text, withCompletionHandler: { (status, success) -> Void in
            if !success {
                if status == "ZERO_RESULTS" {
                    self.showAlertWithMessage("The location could not be found.")
                }
            }else {
                let coordinate = CLLocationCoordinate2D(latitude: self.mapTasks.fetchedAddressLatitude, longitude: self.mapTasks.fetchedAddressLongitude)
                self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 14.0)

                self.setupLocationMarker(coordinate)
            }
        })
        
        searchBarDisplay.text  = ""
        clearMethod()
        
    }

    
    // MARK: - Private Method -
    func clearMethod() {
        toolbarMenu.hidden     = false
        mainTableView.hidden   = true
        searchBarDisplay.resignFirstResponder()
        
    }
    
    func setupLocationMarker(coordinate: CLLocationCoordinate2D)    {
        if locationMarker != nil {
            locationMarker.map = nil
        }
        
        locationMarker                  = GMSMarker(position: coordinate)
        locationMarker.map              = viewMap
        
        locationMarker.title           = mapTasks.fetchedFormattedAddress
        locationMarker.appearAnimation = kGMSMarkerAnimationPop
        locationMarker.icon            = GMSMarker.markerImageWithColor(UIColor.blueColor())
        locationMarker.opacity         = 0.75
        
        locationMarker.flat            = true
        locationMarker.snippet         = "The best place on earth."
        
    }
    func showAlertWithMessage(message: String)                      {
        let alertController = UIAlertController(title: "Information", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }


    // MARK: - Button Action -
    @IBAction func btnLocalSearchAction(sender: UIBarButtonItem)    {
        let center    = CLLocationCoordinate2DMake(37.788204, -122.411937)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport  = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config    = GMSPlacePickerConfig(viewport: viewport)
        placePicker   = GMSPlacePicker(config: config)
        
     
        placePicker?.pickPlaceWithCallback({ (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                println("Place error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                println(place.website)
                
                println("---> : \(place.name)")
                let test = "\n".join(place.formattedAddress.componentsSeparatedByString(", "))
                println("---> : \(test)")
            } else {
                 println("---> :No place selected")
        
            }
        })
        
    }
    
    @IBAction func btnWoldSearchAction(sender: UIBarButtonItem)     {
        
        toolbarMenu.hidden   = true
        mainTableView.hidden = false
        searchBarDisplay.becomeFirstResponder()


    }
    
    @IBAction func btnMapChangeAction(sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.viewMap.mapType = kGMSTypeHybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func btnListAction(sender: AnyObject) {
        self.performSegueWithIdentifier("TListMapSegue", sender: nil)
    }
    
    
    @IBAction func btnSettingAction(sender: UIBarButtonItem) {
    
        self.performSegueWithIdentifier("settingseque", sender: nil)
        
    }
    
}
