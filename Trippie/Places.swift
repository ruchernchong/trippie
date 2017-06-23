import UIKit

class Places: NSObject, NSCoding {

    struct PropertyKey {
        static let name = "name"
        static let address = "address"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("places")

    var name: String
    var address: String
    var latitude: Double
    var longitude: Double

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(latitude, forKey: PropertyKey.latitude)
        aCoder.encode(longitude, forKey: PropertyKey.longitude)
    }

    required convenience init? (coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            return nil
        }
        guard let address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String else {
            return nil
        }
        guard let latitude = aDecoder.decodeObject(forKey: PropertyKey.latitude) as? Double else {
            return nil
        }
        guard let longitude = aDecoder.decodeObject(forKey: PropertyKey.longitude) as? Double else {
            return nil
        }

        self.init(name: name, address: address, latitude: latitude, longitude: longitude)
    }

    init?(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}
