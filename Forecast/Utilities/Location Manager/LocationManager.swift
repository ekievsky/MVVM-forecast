//
//  LocationManager.swift
//  Forecast
//
//  Created by Evgenii Kyivskyi on 1/25/19.
//  Copyright © 2019 Evgenii Kyivskyi. All rights reserved.
//

import CoreLocation
import RxSwift

typealias CityDetermineCompletion = CLGeocodeCompletionHandler

final class LocationManager: NSObject {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    var location = Variable<CLLocationCoordinate2D?>(nil)

    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
    }

    func requestLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }

    func getCity(completion: @escaping CityDetermineCompletion) {
        guard let location2d = self.location.value else {
            return
        }
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: location2d.latitude, longitude: location2d.longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: completion)
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let locValue = manager.location?.coordinate else { return }
        self.location.value = locValue
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
}

