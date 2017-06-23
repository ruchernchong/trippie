import GoogleMaps
import GooglePlaces
import UIKit

class ItienaryTableViewController: UITableViewController {
//    let placesUrlString = "https://maps.googleapis.com/maps/api/place/textsearch/json"
    var places = [Places]()

    private func loadPlaces() -> [Places]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Places.ArchiveUrl.path) as? [Places]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedPlaces = loadPlaces() {
            places += savedPlaces
        } else {
            loadSamplePlaces()
        }
    }

    private func loadSamplePlaces() {
//        let place1 = UIImage(named: "singapore-botanic-gardens")
//        let place2 = UIImage(named: "singapore-zoo")
//        let place3 = UIImage(named: "singapore-night-safari")

        guard let place1 = Places(name: "Singapore Botanic Gardens", address: "123", latitude: 1.3138397, longitude: 103.8159136) else {
            fatalError("Unable to initialise place1")
        }

        guard let place2 = Places(name: "Singapore Zoo", address: "123", latitude: 1.4043485, longitude: 103.793023) else {
            fatalError("Unable to initialise place2")
        }

        guard let place3 = Places(name: "Singapore Night Safari", address: "123", latitude: 1.4021872, longitude: 103.7880606) else {
            fatalError("Unable to initialise place3")
        }

        places += [place1, place2, place3]
    }

    private func savePlaces() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(places, toFile: Places.ArchiveUrl.path)

        if isSuccessfulSave {
            print("Place has been successfully added.")
        } else {
            print("Failed to save meals...")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItienaryTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItienaryTableViewCell else {
            fatalError()
        }

        let place = places[indexPath.row]

        cell.labelName.text = place.name
        cell.labelAddress.text = place.address

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            places.remove(at: indexPath.row)
            savePlaces()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        switch (segue.identifier ?? "") {
//        case "AddItem":
//            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
//        case "ShowDetail":
//            guard let mealDetailViewController = segue.destination as? MealViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            guard let selectedMealCell = sender as? MealTableViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//
//            let selectedMeal = meals[indexPath.row]
//            mealDetailViewController.meal = selectedMeal
//        default:
//            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//        }
//    }
}
