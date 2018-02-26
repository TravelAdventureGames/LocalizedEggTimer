//
//  AmountEggsVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class AmountEggsVC: UIViewController {

    var kamerTemp = false
    var altitude = 0
    var eggSize: EggSize = .Small
    var currentCountry: CurrentCountry = .ElseWhere

    let eggImageView: UIImageView = {
        let eiv = UIImageView()
        eiv.contentMode = .scaleToFill
        eiv.translatesAutoresizingMaskIntoConstraints = false
        eiv.isHidden = true
        eiv.layer.masksToBounds = true
        eiv.isUserInteractionEnabled = true
        eiv.alpha = 0
        return eiv
    }()

    @IBOutlet var amountZachtLbl: UILabel!
    @IBOutlet var amountZachtmediumLbl: UILabel!
    @IBOutlet var amountMediumLbl: UILabel!
    @IBOutlet var amountMediumHardLbl: UILabel!
    @IBOutlet var amountHardLbl: UILabel!
    
    @IBOutlet var zachtImg: UIImageView!
    @IBOutlet var zmImg: UIImageView!
    @IBOutlet var mediumImg: UIImageView!
    @IBOutlet var mhImg: UIImageView!
    @IBOutlet var hardImg: UIImageView!

    @IBOutlet var zachtLbl: UILabel!
    @IBOutlet var zmLbl: UILabel!
    @IBOutlet var mediumLbl: UILabel!
    @IBOutlet var mhLbl: UILabel!
    @IBOutlet var hardLbl: UILabel!

    @IBOutlet var zachtStepper: UIStepper!
    @IBOutlet var zmStepper: UIStepper!
    @IBOutlet var mediumStepper: UIStepper!
    @IBOutlet var mhStepper: UIStepper!
    @IBOutlet var hardStepper: UIStepper!
    
    @IBOutlet var bigEggImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        self.setBackgroundWith(imageName: "snowboard2")
        title = "amountvc.title.hoeveleieren".localized
        addTapgestures()
        addEggImageview()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let color = UIColor.white
        let border: CGFloat = 0.0
        zachtImg.makeCirculair(borderColor: color, borderWidth: border)
        zmImg.makeCirculair(borderColor: color, borderWidth: border)
        mediumImg.makeCirculair(borderColor: color, borderWidth: border)
        mhImg.makeCirculair(borderColor: color, borderWidth: border)
        hardImg.makeCirculair(borderColor: color, borderWidth: border)
        eggImageView.layer.cornerRadius = eggImageView.bounds.width / 2
    }

    private func hideAndShowEggs(sender: UIStepper, lbl: UILabel, img: UIImageView, amountLbl: UILabel) {
        if sender.value == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                lbl.isHidden = true
                img.isHidden = true
                amountLbl.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                lbl.isHidden = false
                img.isHidden = false
                amountLbl.isHidden = false
                amountLbl.text = "\(Int(sender.value)) x"
            })
        }
    }

    private func addTapgestures() {
        let zachtGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(sender:)))
        zachtImg.addGestureRecognizer(zachtGesture)
        let zmGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(sender:)))
        zmImg.addGestureRecognizer(zmGesture)
        let mediumGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(sender:)))
        mediumImg.addGestureRecognizer(mediumGesture)
        let mhGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(sender:)))
        mhImg.addGestureRecognizer(mhGesture)
        let hardGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage(sender:)))
        hardImg.addGestureRecognizer(hardGesture)
    }

    @objc func tappedImage(sender: UITapGestureRecognizer) {
        eggImageView.alpha = 0
        self.eggImageView.isHidden = false
        guard let tappedImageNumber = sender.view?.tag else { return }
        switch tappedImageNumber {
        case 0:
            self.addEggImageview(image: #imageLiteral(resourceName: "eggZacht"))
            print(tappedImageNumber)
        case 1:
            self.addEggImageview(image: #imageLiteral(resourceName: "eggZachtMedium"))
            print(tappedImageNumber)
        case 2:
            self.addEggImageview(image: #imageLiteral(resourceName: "eggMedium"))
            print(tappedImageNumber)
        case 3:
            self.addEggImageview(image: #imageLiteral(resourceName: "eggMediumHard"))
            print(tappedImageNumber)
        case 4:
            self.addEggImageview(image: #imageLiteral(resourceName: "eggHard"))
            print(tappedImageNumber)
        default:
            print("no number")
        }
        UIView.animate(withDuration: 0.7, animations: {
            self.eggImageView.alpha = 1.0
        }) { (done) in

        }
    }

    private func addEggImageview(image: UIImage) {
        eggImageView.image = image
    }

    @objc func dismissEggImageView() {
        UIView.animate(withDuration: 0.7, animations: {
            self.eggImageView.alpha = 0.0
        }) { (done) in
            self.eggImageView.isHidden = true
        }

    }

    private func addEggImageview() {
        view.addSubview(eggImageView)
        eggImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eggImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        eggImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        eggImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true

        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dismissEggImageView))
        eggImageView.addGestureRecognizer(tapgesture)

    }

    private func makeEggs() -> [Egg] {
        let eggs: [Egg] = [
            Egg(roomTemp: kamerTemp, size: eggSize, desiredEggType: .Soft, amount: Int(zachtStepper.value), altitude: altitude, currentCountry: currentCountry),
            Egg(roomTemp: kamerTemp, size: eggSize, desiredEggType: .SoftMedium, amount: Int(zmStepper.value), altitude: altitude, currentCountry: currentCountry),
            Egg(roomTemp: kamerTemp, size: eggSize, desiredEggType: .Medium, amount: Int(mediumStepper.value), altitude: altitude, currentCountry: currentCountry),
            Egg(roomTemp: kamerTemp, size: eggSize, desiredEggType: .MediumHard, amount: Int(mhStepper.value), altitude: altitude, currentCountry: currentCountry),
            Egg(roomTemp: kamerTemp, size: eggSize, desiredEggType: .Hard, amount: Int(hardStepper.value), altitude: altitude, currentCountry: currentCountry)
                           ]
        return eggs
    }

    private func presentAlert() {
        let alert = UIAlertController(title: "amountvc.alert.tile".localized, message: "amountvc.alert.text".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "amountvc.alert.left".localized, style: .default, handler: alertOKPressed))
        alert.addAction(UIAlertAction(title: "amountvc.alert.right".localized, style: .default, handler: alertTipsPressed))
        present(alert, animated: true, completion: nil)
    }
    func alertOKPressed(alert: UIAlertAction) {
        performSegue(withIdentifier:"toTimerVC", sender: self)
    }

    func alertTipsPressed(alert: UIAlertAction) {
        performSegue(withIdentifier:"toInfo", sender: self)
    }

    @IBAction func zachtStepperPushed(_ sender: UIStepper) {
        hideAndShowEggs(sender: sender, lbl: zachtLbl, img: zachtImg, amountLbl: amountZachtLbl)
    }
    @IBAction func zachtMediumStepperPushed(_ sender: UIStepper) {
        hideAndShowEggs(sender: sender, lbl: zmLbl, img: zmImg, amountLbl: amountZachtmediumLbl)
    }
    @IBAction func mediumStepperPushed(_ sender: UIStepper) {
        hideAndShowEggs(sender: sender, lbl: mediumLbl, img: mediumImg, amountLbl: amountMediumLbl)
    }
    @IBAction func mediumHardStepperPushed(_ sender: UIStepper) {
        hideAndShowEggs(sender: sender, lbl: mhLbl, img: mhImg, amountLbl: amountMediumHardLbl)
    }
    @IBAction func hardStepperPushed(_ sender: UIStepper) {
       hideAndShowEggs(sender: sender, lbl: hardLbl, img: hardImg, amountLbl: amountHardLbl)
    }

    @IBAction func didClickSetTimers(_ sender: Any) {

        if UserdefaultManager.didSeeTipAlert {
            performSegue(withIdentifier: "toTimerVC", sender: self)
        } else {
            presentAlert()
            UserdefaultManager.didSeeTipAlert = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTimerVC" {
            let timerVC = segue.destination as! TimerVC
            timerVC.eggs = makeEggs()
        }
    }
}
