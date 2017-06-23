import CoreLocation
import GoogleMaps
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var mapView: GMSMapView?
    var places: Places?
    var locationManager: CLLocationManager!
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let place = places {
            navigationItem.title = place.name
//            marker.position = CLLocationCoordinate2DMake(place.latitude, place.longitude)
//            marker.map = self.mapView!
        }

        self.navigationController?.navigationBar.backItem?.title = "Back"

        mapView = GMSMapView()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        self.view = mapView
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            mapView!.isMyLocationEnabled = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: CLLocationCoordinate2D = (manager.location?.coordinate)!

        mapView!.camera = GMSCameraPosition.camera(withLatitude: newLocation.latitude, longitude: newLocation.longitude, zoom: 20.0)
        mapView!.settings.myLocationButton = true
        self.view = self.mapView!

        marker.position = CLLocationCoordinate2DMake(newLocation.latitude, newLocation.longitude)
        marker.map = self.mapView!
    }

    public func setMarkerFromPlace(_ latitude: Double, longitude: Double) {
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.map = self.mapView!
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        let isPresentingViewPlaceMode = presentingViewController is UINavigationController

        if isPresentingViewPlaceMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError()
        }
    }

    @IBAction func buttonMapType(_ sender: AnyObject) {
        selectMapType()
    }

    func selectMapType() {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.actionSheet)

        let mapTypes = ["Normal", "Hybrid", "Satellite", "Terrain"]

        for mapType in mapTypes {
            let actionMapType = UIAlertAction(title: mapType, style: UIAlertActionStyle.default) { (alertAction) -> Void in
                switch mapType {
                case "Normal":
                    self.mapView!.mapType = .normal
                case "Hybrid":
                    self.mapView!.mapType = .hybrid
                case "Satellite":
                    self.mapView!.mapType = .satellite
                case "Terrain":
                    self.mapView!.mapType = .terrain
                default:
                    self.mapView!.mapType = .normal
                }
                self.view = self.mapView
            }
            actionSheet.addAction(actionMapType)
        }

        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
        }


        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    func saveMapType(_ mapType: String) {

    }
}
