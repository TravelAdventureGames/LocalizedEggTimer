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
    @IBOutlet var chickenView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundLayer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chickenView.layer.cornerRadius = chickenView.bounds.width / 2
        chickenView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        chickenView.layer.borderWidth = 5
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
        self.view.backgroundColor = UIColor.projectBlueWith(alpha: 1)
        //self.setBackgroundWith(imageName: "launchbackground")
        setTitleAndInfo()
        if UserdefaultManager.secondLaunch {
            infoLabel.isHidden = true
            skipButton.isHidden = true
        }
    }

    private func setTitleAndInfo() {

        let title = "launch.title.multiegg".localized
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.monospacedDigitSystemFont(ofSize: 46 * CGFloat.widthMultiplier(), weight: UIFont.Weight(rawValue: UIFont.Weight.RawValue(900)))
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
                UIView.animate(withDuration: 0.3, animations: {
                    self.eggImageview.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 16)
                }, completion: { (done) in
                    if UserdefaultManager.secondLaunch {
                        self.moveToSettingsVC()
                    }
                })
            })
        }
    }
}
