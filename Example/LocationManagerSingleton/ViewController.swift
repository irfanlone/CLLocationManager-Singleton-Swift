//
//  Copyright © 2016 Irfan Lone.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationUpdateProtocol {

    var currentLocation : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdateNotification:", name: kLocationDidChangeNotification, object: nil)

        let LocationMgr = UserLocationManager.SharedManager
        LocationMgr.delegate = self
        
    }
    
    // MARK: - Notifications

    func locationUpdateNotification(notification: NSNotification) {
        let userinfo = notification.userInfo
        self.currentLocation = userinfo!["location"] as! CLLocation
        print("Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Longitude : \(self.currentLocation.coordinate.longitude)")

    }

    // MARK: - LocationUpdateProtocol
    
    func locationDidUpdateToLocation(location: CLLocation) {
        currentLocation = location
        print("Latitude : \(self.currentLocation.coordinate.latitude)")
        print("Longitude : \(self.currentLocation.coordinate.longitude)")
    }
    

}

