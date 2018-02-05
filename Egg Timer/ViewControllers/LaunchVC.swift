//
//  LaunchVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 29-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {


    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var eggImageview: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var skipButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundLayer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animation()
    }

    private func moveToSettingsVC() {
        performSegue(withIdentifier: "toSettingsVC", sender: self)
    }

    @IBAction func didTapLaunchScreen(_ sender: Any) {
        moveToSettingsVC()
    }
    @IBAction func didTapSkipButton(_ sender: Any) {
        moveToSettingsVC()
    }

    private func setBackgroundLayer() {
        self.setBackgroundWith(imageName: "launchbackground")
        setTitleAndInfo()
        if UserdefaultManager.secondLaunch {
            infoLabel.isHidden = true
            skipButton.isHidden = true
        }
    }

    private func setTitleAndInfo() {

        let title = "launch.title.multiegg".localized
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .strokeColor : UIColor.white,
            .foregroundColor : UIColor.projectBlueWith(alpha: 1),
            .strokeWidth : -6.0,
            .font : UIFont.monospacedDigitSystemFont(ofSize: 48, weight: UIFont.Weight(rawValue: UIFont.Weight.RawValue(900)))
        ]

        let text = "launch.lbel.text".localized
        let infoTextAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 18 * CGFloat.widthMultiplier())
        ]

        titleLabel.attributedText = NSMutableAttributedString(string: title, attributes: strokeTextAttributes)
        infoLabel.attributedText = NSMutableAttributedString(string: text, attributes: infoTextAttributes)
        skipButton.setTitle("lanchvc.button.skip".localized, for: .normal)
    }

    private func animation() {
        titleLabel.alpha = 0
        infoLabel.alpha = 0
        skipButton.alpha = 0
        //eggImageview.alpha = 0
        let y = (self.view.bounds.height / 2) + self.eggImageview.frame.height
        self.eggImageview.transform = CGAffineTransform(translationX: 0, y: -y)

        UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.titleLabel.alpha = 1
            self.infoLabel.alpha = 1
            self.skipButton.alpha = 1

        }) { (succes) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.eggImageview.transform = .identity
            }, completion: { (finished) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    if UserdefaultManager.secondLaunch {
                        self.moveToSettingsVC()
                    }
                })
            })
        }
    }
}
