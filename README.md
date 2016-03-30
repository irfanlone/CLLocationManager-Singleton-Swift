# CLLocationManager-Singleton-Swift


    import MapKit

    protocol LocationUpdateProtocol {
      func locationDidUpdateToLocation(location : CLLocation)
    }

    /// Notification on update of location. UserInfo contains CLLocation for key "location"
    let kLocationDidChangeNotification = "LocationDidChangeNotification"

    class UserLocationManager: NSObject, CLLocationManagerDelegate {

        static let SharedManager = UserLocationManager()

        private var locationManager = CLLocationManager()

        var currentLocation : CLLocation?

        var delegate : LocationUpdateProtocol!

        private override init () {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }

        // MARK: - CLLocationManagerDelegate

        func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
            currentLocation = newLocation
            let userInfo : NSDictionary = ["location" : currentLocation!]

            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.delegate.locationDidUpdateToLocation(self.currentLocation!)
                NSNotificationCenter.defaultCenter().postNotificationName(kLocationDidChangeNotification, object: self, userInfo: userInfo as [NSObject : AnyObject])
            }
        }

    }

##Usage:

In your view-controller, do the initialization

      let LocationMgr = UserLocationManager.SharedManager
      LocationMgr.delegate = self

Implement the proctocol - LocationUpdateProtocol
    
    // MARK: - LocationUpdateProtocol
    func locationDidUpdateToLocation(location: CLLocation) {
        currentLocation = location
        print(currentLocation)
    }
    
or you can choose to receive the notifications

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdateNotification:", name: kLocationDidChangeNotification, object: nil)

Also add the following Keys to your info.plist

    NSLocationAlwaysUsageDescription
    NSLocationWhenInUseUsageDescription

#Contribution:

Any contribution is welcome. Just submit a pull request.
    
#Copyright and License
The source code is released under the MIT License (MIT).

Copyright (c) 2016 Irfan Lone

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
