//
//  EggMeasuringVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 13-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit
import UIDeviceComplete

class EggMeasuringVC: UIViewController {

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var titleLable: UILabel!
    
    let eggMeasureImageview: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "eggsize9_Eiergrootes")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnchorsImageview()
        titleLable.text = "eggmeasurevc.lable.title".localized
        titleLable.textColor = UIColor.projectBlueWith(alpha: 1.0)
    }

    @IBAction func didClickCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func getSizeFromCyrrentCountry() -> CGSize {
        switch UserdefaultManager.currentCountryLocation {
        case "ELSEWHERE":
            return CGSize(width: 47, height: 60.5)
        case "US":
            return CGSize(width: 42, height: 55.5)
        default:
            return CGSize(width: 47, height: 60.5)
        }
    }

    private func getSizeUIImageView() -> CGSize {
        let ppi = getPPI()
        let pixelsPerPoint = UIScreen.main.nativeBounds.width / UIScreen.main.bounds.width
        let realWidth = getSizeFromCyrrentCountry().width
        let realHeight = getSizeFromCyrrentCountry().height
        let width: CGFloat = getIncheFrom(mm: realWidth) * ppi / pixelsPerPoint
        let height: CGFloat = getIncheFrom(mm: realHeight) * ppi / pixelsPerPoint
        print(realWidth, realHeight)
        return CGSize(width: width, height: height)
    }

    private func getPPI() -> CGFloat {
        switch UIDevice.current.dc.deviceModel {
        case .iPhoneX:
            return 458
        case .iPhone6Plus, .iPhone7Plus, .iPhone8Plus:
            return 401
        default:
            return 326
        }
    }

    private func getIncheFrom(mm: CGFloat) -> CGFloat {
        let factor: CGFloat = 0.0393700787
        return factor * mm
    }

    private func setAnchorsImageview() {
        let size = getSizeUIImageView()
        view.addSubview(eggMeasureImageview)
        eggMeasureImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eggMeasureImageview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30 * CGFloat.heightMultiplier()).isActive = true
        eggMeasureImageview.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        eggMeasureImageview.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
}
