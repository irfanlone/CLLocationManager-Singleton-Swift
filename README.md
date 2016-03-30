# CLLocationManager-Singleton-Swift


    import MapKit

    protocol LocationUpdateProtocol {
      func locationDidUpdateToLocation(location : CLLocation)
    }


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
          if currentLocation == nil {
              currentLocation = locationManager.location
          }
          currentLocation = newLocation;
          self.delegate.locationDidUpdateToLocation(currentLocation!)
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
