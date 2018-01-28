//
//  TimerVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {

    var player: AudioPlayer?

    @IBOutlet var timerStackview: UIStackView!
    @IBOutlet var doneStackview: UIStackView!
    @IBOutlet var timerLabelSTackview: UIStackView!
    
    @IBOutlet var startTimerBtn: UIButton!

    @IBOutlet var zachtTimerLbl: UILabel!
    @IBOutlet var zmTimerLbl: UILabel!
    @IBOutlet var mediumTimerLbl: UILabel!
    @IBOutlet var mhTimerLbl: UILabel!
    @IBOutlet var hardTimerLbl: UILabel!

    @IBOutlet var zachtLbl: UILabel!
    @IBOutlet var zmLbl: UILabel!
    @IBOutlet var mediumLbl: UILabel!
    @IBOutlet var mhLbl: UILabel!
    @IBOutlet var hardLbl: UILabel!

    @IBOutlet var zachtDoneBtn: UIButton!
    @IBOutlet var zmDoneButton: UIButton!
    @IBOutlet var mediumDoneBtn: UIButton!
    @IBOutlet var mhDoneBtn: UIButton!
    @IBOutlet var hardDoneBtn: UIButton!

    @IBOutlet var alertlabel: UILabelPadding!
    var alertText: [String] = ["","","","",""]
    var isFirstText = true

    let zachtShapeLayer = CAShapeLayer()
    let zmShapeLayer = CAShapeLayer()
    let mediumShapeLayer = CAShapeLayer()
    let mhShapeLayer = CAShapeLayer()
    let hardShapeLayer = CAShapeLayer()

    var timerZacht = Timer()
    var timerzm = Timer()
    var timermedium = Timer()
    var timermh = Timer()
    var timerHard = Timer()
    var upTimer = Timer()

    var zachtDuration = 0
    var zmDuration = 0
    var mediumDuration = 0
    var mhDuration = 0
    var hardDuration = 0

    let projectblue = UIColor(red: 0/255, green: 82/255, blue: 159/255, alpha: 1.0)

    var upTime = 0
    var longestDuration = 0

    var eggs: [Egg] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AudioPlayer()
        startTimerBtn.addTarget(self, action: #selector(startTimers), for: .touchUpInside)
        calculateBoilingTimesAndLongestDuration()
        SetBeginUI()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addTimers()
        setBorders(labels: [zachtLbl,zmLbl,mediumLbl,mhLbl,hardLbl])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        runUpTimer()
    }

    private func setBorders(labels: [UILabel]) {
        for label in labels {
            label.layer.borderColor = projectblue.cgColor
            label.layer.borderWidth = 0.5
        }
    }
    func setDoneBtnUI(btn: UIButton) {
        btn.layer.cornerRadius = btn.bounds.width / 2
        btn.layer.borderColor = projectblue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.backgroundColor = UIColor.white.withAlphaComponent(0.65).cgColor
        btn.setTitleColor(projectblue, for: .normal)
        btn.setTitle("Stop", for: .normal)
        btn.isEnabled = true
    }

    private func SetBeginUI() {
        self.setBackgroundWith(imageName: "snowboard3")
        title = "timervc.title.text".localized
        let fontweight = UIFont.Weight(rawValue: 300)
        let size: CGFloat = 14
        zachtTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        zmTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        mediumTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        mhTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        hardTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        startTimerBtn.alpha = 0
        alertlabel.isHidden = true
        alertlabel.roundedCorners(radius: 15, borderColor: projectblue, borderWidth: 2)
    }

    private func calculateBoilingTimesAndLongestDuration() {
        var durations: [Int] = []
        for egg in eggs {
            if egg.amount != 0 {
                switch egg.desiredEggType {
                case .Soft:
                    zachtDuration = BoilingtimeCalculator.shared.calculatedBoilingtime(egg: egg)
                    durations.append(zachtDuration)
                case .SoftMedium:
                    zmDuration = BoilingtimeCalculator.shared.calculatedBoilingtime(egg: egg)
                    durations.append(zmDuration)
                case .Medium:
                    mediumDuration = BoilingtimeCalculator.shared.calculatedBoilingtime(egg: egg)
                    durations.append(mediumDuration)
                case .MediumHard:
                    mhDuration = BoilingtimeCalculator.shared.calculatedBoilingtime(egg: egg)
                    durations.append(mhDuration)
                case .Hard:
                    hardDuration = BoilingtimeCalculator.shared.calculatedBoilingtime(egg: egg)
                    durations.append(hardDuration)
                }
            }
        }
        if durations.count > 0 {
            longestDuration = durations.sorted { $0 > $1 }[0]
        }
    }

    private func styleTimerLabels() {
        let subViews = timerStackview.arrangedSubviews
        for subview in subViews {
            subview.layer.cornerRadius = subview.frame.height/2
            subview.layer.borderColor = UIColor.white.cgColor
            subview.layer.borderWidth = 2.2
            subview.clipsToBounds = true
        }
    }

    private func runUpTimer() {
        upTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(presentTimerWithAnimation), userInfo: nil, repeats: true)
    }

    private func fadeOutLabelsFromStack(lbl: UILabel, timerLbl: UILabel, btn: UIButton) {
        UIView.animate(withDuration: 0.6) {
            lbl.alpha = 0
            timerLbl.alpha = 0
            btn.alpha = 0
        }
    }

    func presentAlert(index: Int) -> String {
        alertlabel.isHidden = false
        let egg = eggs[index]
        let eggAmount = egg.amount
        switch eggAmount {
        case 1:
            if isFirstText {
                alertText[index] = "Haal 1 \(egg.desiredEggType.nameSingle) uit de pan."
                isFirstText = false
            } else {
                alertText[index] = "\nHaal 1 \(egg.desiredEggType.nameSingle) uit de pan."
            }
        default:
            if isFirstText {
                alertText[index] = "Haal \(eggAmount) \(egg.desiredEggType.nameMultiple) uit de pan."
                isFirstText = false
            } else {
                alertText[index] = "\n\nHaal \(eggAmount) \(egg.desiredEggType.nameMultiple) uit de pan."
            }
        }
        let sentence = alertText.flatMap({$0}).joined()
        return sentence
    }
    //called on stopbuttonclick
    func removeAlertText(index: Int) -> String {
        alertText[index] = ""
        let sentence = alertText.flatMap({$0}).joined()
        return sentence
    }
    // MARK: fast count-up to timervalues at presentation of vc
    @objc private func presentTimerWithAnimation() {
        for egg in eggs {
            if egg.amount != 0 {
                if upTime < longestDuration {
                    switch egg.desiredEggType {
                    case .Soft:
                        if upTime > zachtDuration {
                            zachtTimerLbl.text = timeString(time: TimeInterval(zachtDuration))
                        } else {
                            upTime += 4
                            zachtTimerLbl.text = timeString(time: TimeInterval(upTime))
                        }
                    case .SoftMedium:
                        if upTime > zmDuration {
                            zmTimerLbl.text = timeString(time: TimeInterval(zmDuration))
                        } else {
                            upTime += 8
                            zmTimerLbl.text = timeString(time: TimeInterval(upTime))
                        }
                    case .Medium:
                        if upTime > mediumDuration {
                            mediumTimerLbl.text = timeString(time: TimeInterval(mediumDuration))
                        } else {
                            upTime += 8
                            mediumTimerLbl.text = timeString(time: TimeInterval(upTime))
                        }
                    case .MediumHard:
                        if upTime > mhDuration {
                            mhTimerLbl.text = timeString(time: TimeInterval(mhDuration))
                        } else {
                            upTime += 12
                            mhTimerLbl.text = timeString(time: TimeInterval(upTime))
                        }
                    case .Hard:
                        if upTime > hardDuration {
                            hardTimerLbl.text = timeString(time: TimeInterval(hardDuration))
                        } else {
                            upTime += 16
                            hardTimerLbl.text = timeString(time: TimeInterval(upTime))
                        }
                    }
                } else {
                    upTimer.invalidate()
                    zachtTimerLbl.text = timeString(time: TimeInterval(zachtDuration))
                    zmTimerLbl.text = timeString(time: TimeInterval(zmDuration))
                    mediumTimerLbl.text = timeString(time: TimeInterval(mediumDuration))
                    mhTimerLbl.text = timeString(time: TimeInterval(mhDuration))
                    hardTimerLbl.text = timeString(time: TimeInterval(hardDuration))
                    UIView.animate(withDuration: 1, animations: {
                        self.startTimerBtn.alpha = 0.7
                    })
                }
            }
        }
    }
    
    private func addTimers() {
        for egg in eggs {
            if egg.amount != 0 {
                switch egg.desiredEggType {
                case .Soft:
                    zachtTimerLbl.isHidden = false
                    zachtLbl.isHidden = false
                    zachtDoneBtn.isHidden = false
                case .SoftMedium:
                    zmTimerLbl.isHidden = false
                    zmLbl.isHidden = false
                    zmDoneButton.isHidden = false
                case .Medium:
                    mediumLbl.isHidden = false
                    mediumTimerLbl.isHidden = false
                    mediumDoneBtn.isHidden = false
                case .MediumHard:
                    mhLbl.isHidden = false
                    mhTimerLbl.isHidden = false
                    mhDoneBtn.isHidden = false
                case .Hard:
                    hardLbl.isHidden = false
                    hardTimerLbl.isHidden = false
                    hardDoneBtn.isHidden = false
                }
            }
        }
        styleTimerLabels()
    }
    private func setViewsOnStoptimer(lbl: UILabel, timerLbl: UILabel, btn: UIButton, index: Int) {
        timerLbl.layer.removeAllAnimations()
        player?.stopPlaying()
        fadeOutLabelsFromStack(lbl: lbl, timerLbl: timerLbl, btn: btn)
        alertlabel.text = removeAlertText(index: index)
        
        //MARK: Check if last timer has been stopped by user. Then remove alertview
        var notZeroIndices: [Int] = []
        for egg in eggs {
            if egg.amount > 0 {
                notZeroIndices.append(egg.desiredEggType.place)
            }
        }
        let highestIndex = notZeroIndices.sorted() { $0 > $1 }[0]
        if highestIndex == index {
            alertlabel.removeFromSuperview()
        }
    }

    @objc func startTimers() {
        startAvailableTimers()
        startTimerBtn.alpha = 0
    }
    @IBAction func zachtDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: zachtLbl, timerLbl: zachtTimerLbl, btn: zachtDoneBtn, index: 0)
    }
    @IBAction func zmDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: zmLbl, timerLbl: zmTimerLbl, btn: zmDoneButton, index: 1)
    }
    @IBAction func mediumDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: mediumLbl, timerLbl: mediumTimerLbl, btn: mediumDoneBtn, index: 2)
    }
    @IBAction func mhDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: mhLbl, timerLbl: mhTimerLbl, btn: mhDoneBtn, index: 3)
    }
    @IBAction func hardDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: hardLbl, timerLbl: hardTimerLbl, btn: hardDoneBtn, index: 4)
    }

}
