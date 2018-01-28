//
//  SettingsVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit
import CoreLocation

class SettingsVC: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var uitleAltitudeLabel: UILabel!
    @IBOutlet var hoeKoudLabel: UILabel!
    @IBOutlet var kamertempLbl: UILabel!
    @IBOutlet var fridgelabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var eggBackground: UIView!
    @IBOutlet var kleinLabel: UILabel!
    @IBOutlet var mediumLabel: UILabel!
    @IBOutlet var largeLabel: UILabel!
    @IBOutlet var verderButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var grootButton: UIButton!
    @IBOutlet var kleinButton: UIButton!

    

    let selectedColor = UIColor(red: 207/255, green: 44/255, blue: 82/255, alpha: 1)

    var kleinButtonIsHighlited: Bool = false {
        didSet {
            if !kleinButtonIsHighlited {
                kleinButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
                kleinButtonIsHighlited = false
            } else {
                kleinButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: selectedColor), for: .normal)
                kleinButtonIsHighlited = true
                grootButtonIsHighlited = false
                mediumButtonIsHighlited = false
            }
        }
    }

    var mediumButtonIsHighlited: Bool = false {
        didSet {
            if !mediumButtonIsHighlited {
                mediumButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
                mediumButtonIsHighlited = false
            } else {
                mediumButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: selectedColor), for: .normal)
                kleinButtonIsHighlited = false
                grootButtonIsHighlited = false
                mediumButtonIsHighlited = true
            }
        }
    }

    var grootButtonIsHighlited: Bool = false {
        didSet {
            if !grootButtonIsHighlited {
                grootButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
                grootButtonIsHighlited = false
            } else {
                grootButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: selectedColor), for: .normal)
                kleinButtonIsHighlited = false
                grootButtonIsHighlited = true
                mediumButtonIsHighlited = false
            }
        }
    }

    @IBAction func isFromFridge(_ sender: Any) {
        isKamerTemp = !isKamerTemp
        print(isKamerTemp)
    }

    var isKamerTemp = false
    var altitude: Int = 0
    var eggSize: EggSize = .Small
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setUpLocationManager()
        setShades()
        setTitle()
    }

    private func setBackgroundImage() {
        self.setBackgroundWith(imageName: "snowboard7")
        kleinButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
        mediumButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
        grootButton.setImage(#imageLiteral(resourceName: "egg").tinted(with: .white), for: .normal)
    }

    private func setTitle() {
        title = "setingsvc.title.overeieren".localized
        uitleAltitudeLabel.font = UIFont.systemFont(ofSize: 16*CGFloat.widthMultiplier())
    }

    private func setShades() {
        uitleAltitudeLabel.textDropShadow(color: .black)
        hoeKoudLabel.textDropShadow(color: .black)
        altitudeLabel.textDropShadow(color: .black)
        fridgelabel.textDropShadow(color: .black)
        kamertempLbl.textDropShadow(color: .black)
        sizeLabel.textDropShadow(color: .black)
    }

    private func setUpLocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }

        altitude = Int(lastLocation.altitude)
        let firstString = "Settingsvc.alituted.labelJebevindt".localized
        let secondString = "Settingsvc.alituted.labelMeterHoog".localized
        let main_string = "\(firstString) \(altitude) \(secondString)"
        let string_to_color = main_string.westernArabicNumeralsOnly
        let range = (main_string as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:main_string)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
        altitudeLabel.attributedText = attributedString
        locationManager.stopUpdatingLocation()
    }

    @IBAction func clickedVerderButton(_ sender: Any) {
        
    }
    @IBAction func smallEggSelected(_ sender: Any) {
        kleinButtonIsHighlited = !kleinButtonIsHighlited
        eggSize = .Small
    }

    @IBAction func mediumEggSelected(_ sender: Any) {
        mediumButtonIsHighlited = !mediumButtonIsHighlited
        eggSize = .Medium
    }
    @IBAction func largeEggSelected(_ sender: Any) {
        grootButtonIsHighlited = !grootButtonIsHighlited
        eggSize = .Large
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to amountVC" {
            let aoeVC =  segue.destination as! AmountEggsVC
            aoeVC.altitude = altitude
            aoeVC.eggSize = eggSize
            aoeVC.kamerTemp = isKamerTemp
            print(eggSize)
            print(isKamerTemp)

        }
    }
    
}
