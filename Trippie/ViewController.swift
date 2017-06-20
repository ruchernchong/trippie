import CoreLocation
import GoogleMaps
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var mapView: GMSMapView?
    var locationManager: CLLocationManager!
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            mapView!.isMyLocationEnabled = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: CLLocationCoordinate2D = (manager.location?.coordinate)!

        mapView!.camera = GMSCameraPosition.camera(withLatitude: newLocation.latitude, longitude: newLocation.longitude, zoom: 16.0)
        mapView!.settings.myLocationButton = true
        self.view = self.mapView!

        marker.position = CLLocationCoordinate2DMake(newLocation.latitude, newLocation.longitude)
        marker.map = self.mapView!
    }
}

