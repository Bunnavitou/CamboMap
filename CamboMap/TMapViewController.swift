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
    
    var placeName = "Yo is here man" as NSString
    
    
    var placePicker: GMSPlacePicker?

    var locationManager = CLLocationManager()
    var mapTasks = MapTasks()
    var locationMarker: GMSMarker!
    
    
    var latitudeCurrLocation  : Double!
    var longitudeCurrLocation : Double!
    
    
    var didLocation = true

    //=======For Check
    var checkMoveMap = false
    
    //=======UILabel NoData
    var labelNoResult : UILabel!
    lazy var searchBarDisplay : UISearchBar = {
        var searchBar   = UISearchBar()
        searchBar.frame = CGRectMake(0, 0, self.mainTableView.frame.size.width, 44.0)
        searchBar.delegate          = self
        searchBar.tintColor         = UIColor(red: 0 / 255, green: 154 / 255, blue: 255 / 255, alpha: 1.0)
        searchBar.barTintColor      = UIColor(red: 0 / 255, green: 154 / 255, blue: 255 / 255, alpha: 1.0)
        return searchBar
    }()
    // MARK: - View LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        mainTableView.hidden = true
        
        
        locationManager.delegate = self
        //======Ask User to allow locaition
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter  = 1.0;
        locationManager.desiredAccuracy	= kCLLocationAccuracyBest;
        locationManager.distanceFilter  = kCLDistanceFilterNone;
  
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(11.558363, longitude: 104.911911, zoom: 16.0)
        viewMap.camera = camera
        viewMap.settings.compassButton    = true
        viewMap.delegate = self
        
        
        //=======UILabel NoData
        labelNoResult = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2 - 50, 60, 100, 20))
        labelNoResult.textAlignment = NSTextAlignment.Center
        labelNoResult.text = "No Result"
        mainTableView.addSubview(labelNoResult)
    
        
        
        AppUtils.settingLeftButton(self, action: "leftButtonClicked:", normalImageCode: "Yo-Back.png", highlightImageCode: "Yo-Back.png")
    }
    
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden  = true
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    // MARK: - GMSMapViewDelegate method implementation -
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        print("==> \(coordinate.latitude) -- \(coordinate.longitude)")
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
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        locationManager.stopUpdatingHeading()
        
        //========ADD Copy
        viewMap.camera = GMSCameraPosition.cameraWithTarget(locationManager.location.coordinate, zoom: 16.0)
        
        SingleTonManager.ShareSingleTonManager().SlocationMananger = locationManager
        
        longitudeCurrLocation = locationManager.location.coordinate.longitude
        latitudeCurrLocation  = locationManager.location.coordinate.latitude
        
        viewMap.settings.myLocationButton = true
        didLocation = true
     
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingHeading()
        
        ///===Point to Cambodia Stadium
        longitudeCurrLocation = 11.558363
        latitudeCurrLocation  = 104.911911
        didLocation = false
        return
    }
    
    // MARK: - UITableView Method Area
    func numberOfSectionsInTableView(tableView: UITableView) -> Int                             {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int           {

        if(SysUtils.isNull(self.mapTasks.allResult)){
            return 1
        }else{
            return self.mapTasks.allResult.count
        }
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?      {
        return searchBarDisplay
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat    {
        return 44
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier) as UITableViewCell
        }

        if(SysUtils.isNull(self.mapTasks.allResult)){
            return cell!
        }
        labelNoResult.hidden=true
        cell!.textLabel?.font        = UIFont.systemFontOfSize(15)
        cell!.textLabel?.textColor   = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
        cell!.detailTextLabel?.font  = UIFont.systemFontOfSize(12)
        cell!.detailTextLabel?.textColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1)
        
        cell?.textLabel?.text = self.mapTasks.allResult[indexPath.row].valueForKey("formatted_address") as? String
    
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)      {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
      
        print(self.mapTasks.allResult[indexPath.row])
    
        
        self.longitudeCurrLocation = self.mapTasks.allResult[indexPath.row].valueForKey("geometry")?.valueForKey("location")?.valueForKey("lng") as? Double
        self.latitudeCurrLocation  = self.mapTasks.allResult[indexPath.row].valueForKey("geometry")?.valueForKey("location")?.valueForKey("lat") as? Double
        self.placeName             = (self.mapTasks.allResult[indexPath.row].valueForKey("formatted_address") as? String)!

        println(self.longitudeCurrLocation)
        println(self.latitudeCurrLocation)
        
        let coordinate = CLLocationCoordinate2D(latitude: self.latitudeCurrLocation , longitude: self.longitudeCurrLocation)
//        let coordinateTest = CLLocationCoordinate2D(latitude: self.latitudeCurrLocation - 0.01900 , longitude: self.longitudeCurrLocation + 0.0092)
        self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 14.0)
        self.setupLocationMarker(coordinate)
    }
    
    // MARK: - UISearchBar Method Area -
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        if(SysUtils.isNull(self.mapTasks.allResult)){
            mainTableViewHeightConstraint.constant = 3 * 44;
        }else{
            if(self.mapTasks.allResult.count >  6){
                self.mainTableViewHeightConstraint.constant = 7 * 44;
            }else if (self.mapTasks.allResult.count == 1){
                self.mainTableViewHeightConstraint.constant = 2 * 44;
            }else{
                self.mainTableViewHeightConstraint.constant = CGFloat(self.mapTasks.allResult.count) * 44 + 44;
            }
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar){

        self.mapTasks.geocodeAddress(searchBar.text, withCompletionHandler: { (status, success) -> Void in
            if !success {
                if status == "ZERO_RESULTS" {
                    self.showAlertWithMessage("The location could not be found.")
                }
            }else {
                if(self.mapTasks.allResult.count >  8){
                    self.mainTableViewHeightConstraint.constant = 9 * 44;
                }else if (self.mapTasks.allResult.count == 1){
                    self.mainTableViewHeightConstraint.constant = 2 * 44;
                }else{
                    self.mainTableViewHeightConstraint.constant = CGFloat(self.mapTasks.allResult.count) * 44 + 44;
                }
                self.mainTableView.reloadData()
            }
        })
        searchBarDisplay.text  = ""

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
        
        locationMarker.tappable  = true
        locationMarker.flat            = true
        locationMarker.snippet         = placeName as String
        
    }
    func showAlertWithMessage(message: String)                      {
        let alertController = UIAlertController(title: "Information", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Sever Relate Method Area
    func sendToServer(text : String)    {

        
    }

    
    // MARK: - Button Action -
    @IBAction func btnLocalSearchAction(sender: UIBarButtonItem)    {
        
        let center    = CLLocationCoordinate2DMake(latitudeCurrLocation, longitudeCurrLocation)
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
            
                self.placeName = place.name
                self.longitudeCurrLocation = place.coordinate.longitude
                self.latitudeCurrLocation  = place.coordinate.latitude
                
                let coordinate = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                self.viewMap.camera = GMSCameraPosition.cameraWithTarget(coordinate, zoom: 16.0)
        
                self.setupLocationMarker(coordinate)
    
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
    @IBAction func btnMapChangeAction(sender: UIBarButtonItem)      {
        
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
    @IBAction func btnListAction(sender: AnyObject)                 {
        self.performSegueWithIdentifier("TListMapSegue", sender: nil)
    }
    @IBAction func btnSettingAction(sender: UIBarButtonItem)        {
    
        self.performSegueWithIdentifier("settingseque", sender: nil)
        
    }
    func leftButtonClicked(sender: UIButton!) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
