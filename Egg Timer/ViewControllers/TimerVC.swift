//
//  TimerVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit
import AVFoundation

class TimerVC: UIViewController {

    var player: AVAudioPlayer?

    @IBOutlet var timerStackview: UIStackView!
    @IBOutlet var doneStackview: UIStackView!
    @IBOutlet var timerLabelSTackview: UIStackView!
    
    @IBOutlet var cancelButton: UIBarButtonItem!
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

    @IBOutlet var zachtDoneBtn: StopButton!
    @IBOutlet var zmDoneButton: StopButton!
    @IBOutlet var mediumDoneBtn: StopButton!
    @IBOutlet var mhDoneBtn: StopButton!
    @IBOutlet var hardDoneBtn: StopButton!

    @IBOutlet var zeerZachtAlertLabel: AlertTextLabel!
    @IBOutlet var zachtAlertLabel: AlertTextLabel!
    @IBOutlet var mediumAlertLabel: AlertTextLabel!
    @IBOutlet var mediumHardAlertLabel: AlertTextLabel!
    @IBOutlet var hardAlertLabel: AlertTextLabel!
    @IBOutlet var infoImagview: UIImageView!
    
    var timerZacht = Timer()
    var timerzm = Timer()
    var timermedium = Timer()
    var timermh = Timer()
    var timerHard = Timer()
    var upTimer = Timer()

    var zachtTimerExpired = false
    var zmTimerExpired = false
    var mediumTimerExpired = false
    var mhTimerExpired = false
    var hardTimerExpired = false

    var zachtDuration = 0
    var zmDuration = 0
    var mediumDuration = 0
    var mhDuration = 0
    var hardDuration = 0

    var allDurations: [Int] = []

    let projectblue = UIColor(red: 0/255, green: 82/255, blue: 159/255, alpha: 1.0)

    var upTime = 0
    var longestDuration = 0
    var sessionIsactive = false

    var timestampOnLeavingApp: CFTimeInterval = 0
    var timestampOnReenteringApp: CFTimeInterval = 0
    var expiredTimeInBackground: Int = 0

    var eggs: [Egg] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startTimerBtn.addTarget(self, action: #selector(startTimers), for: .touchUpInside)
        calculateBoilingTimesAndLongestDuration()
        SetBeginUI()
        sessionIsactive = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addTimers()
        setBorders(labels: [zachtLbl,zmLbl,mediumLbl,mhLbl,hardLbl])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        runUpTimer()
        addTapgestureToFadeOutInfoImageview()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func addTapgestureToFadeOutInfoImageview() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(fadeOutInfoLabelAddTap))
        view.addGestureRecognizer(tapgesture)
    }

    @objc func fadeOutInfoLabelAddTap() {
        UIView.animate(withDuration: 0.4, animations: {
            self.infoImagview.alpha = 0
        }) { (done) in
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    private func setupNotificationOnEnteringBackground() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    private func setupNotificationOnEnteringForeground() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovesToForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    // MARK:- functions to handle app moved to background
    @objc func appMovedToBackground() {
        if sessionIsactive {
            timestampOnLeavingApp = NSDate().timeIntervalSince1970
            invalidateAllTimers()
        }
    }
    @objc func appMovesToForeground() {
        if sessionIsactive {
            //MARK:- App comes back from background. Timers must be set to new values. Old timers must be invalidated
            timestampOnReenteringApp = NSDate().timeIntervalSince1970
            getExpiredTimeInBackgroundModus()
            updateTimerDurations()
            invalidateAllTimers()
            startAvailableTimers()
        }
    }
    private func getExpiredTimeInBackgroundModus() {
        let expiredTime = timestampOnReenteringApp - timestampOnLeavingApp
        expiredTimeInBackground = Int(expiredTime)
    }
    private func updateTimerDurations() {
        setNewTimerValue(oldDuration: &zachtDuration)
        setNewTimerValue(oldDuration: &zmDuration)
        setNewTimerValue(oldDuration: &mediumDuration)
        setNewTimerValue(oldDuration: &mhDuration)
        setNewTimerValue(oldDuration: &hardDuration)
        print("The newdurations are \(zachtDuration) \(zmDuration) \(mediumDuration) \(mhDuration)")
    }
    private func setNewTimerValue(oldDuration: inout Int) {
        let newDuration = oldDuration - expiredTimeInBackground
        if newDuration > 0 {
            oldDuration = newDuration
        } else {
            oldDuration = 1
        }
    }

    private func scheduleNotifications() {
        for egg in eggs {
            if egg.amount > 0 {
                switch egg.desiredEggType {
                case .Soft:
                    NotificationManager.shared.scheduleNotification(notificationCase: .Zacht, firedate: TimeInterval(zachtDuration), identifier: "soft_notification", eggAmount: egg.amount)
                case .SoftMedium:
                    NotificationManager.shared.scheduleNotification(notificationCase: .ZachtMedium, firedate: TimeInterval(zmDuration), identifier: "softmedium_notification", eggAmount: egg.amount)
                case .Medium:
                    NotificationManager.shared.scheduleNotification(notificationCase: .Medium, firedate: TimeInterval(mediumDuration), identifier: "medium_notification", eggAmount: egg.amount)
                case .MediumHard:
                    NotificationManager.shared.scheduleNotification(notificationCase: .MediumHard, firedate: TimeInterval(mhDuration), identifier: "mediumhard_notification", eggAmount: egg.amount)
                case .Hard:
                    NotificationManager.shared.scheduleNotification(notificationCase: .Hard, firedate: TimeInterval(hardDuration), identifier: "hard_notification", eggAmount: egg.amount)
                }
            }
        }
    }

    private func invalidateAllTimers() {
        timerZacht.invalidate()
        timerzm.invalidate()
        timermedium.invalidate()
        timermh.invalidate()
        timerHard.invalidate()
    }

    private func setBorders(labels: [UILabel]) {
        for label in labels {
            label.layer.borderColor = projectblue.cgColor
            label.layer.borderWidth = 0.5
        }
    }
    private func hideDoneButtons() {
        zachtDoneBtn.alpha = 0
        zmDoneButton.alpha = 0
        mediumDoneBtn.alpha = 0
        mhDoneBtn.alpha = 0
        hardDoneBtn.alpha = 0
    }

    private func SetBeginUI() {
        self.setBackgroundWith(imageName: "snowboard3")
        title = "timervc.title.text".localized
        infoImagview.image = UIImage(named: "timervc.imageview.instructions".localized)
        let fontweight = UIFont.Weight(rawValue: 300)
        let size: CGFloat = 14
        zachtTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        zmTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        mediumTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        mhTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        hardTimerLbl.font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: fontweight)
        startTimerBtn.alpha = 0
        cancelButton.isEnabled = false
        infoImagview.alpha = 0.0
        hideDoneButtons()
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

    func presentAlertInStackview(label: UILabel, index: Int) {
        label.isHidden = false
        let egg = eggs[index]
        let eggamount = egg.amount
        let firstPartOfSentence = "timervc.label.haal".localized
        let secondPartOfSence = "timervc.label.uitdepan".localized
        switch eggamount {
        case 1:
            label.text = "\(firstPartOfSentence) \(eggamount) \(egg.desiredEggType.nameSingle) \(secondPartOfSence)"
        default:
            label.text = "\(firstPartOfSentence) \(eggamount) \(egg.desiredEggType.nameMultiple) \(secondPartOfSence)"
        }
    }
    func removeAlertInStackview(label: UILabel) {
        label.isHidden = true
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
                        self.infoImagview.alpha = 1.0
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
        fadeOutLabelsFromStack(lbl: lbl, timerLbl: timerLbl, btn: btn)
        
        //MARK: Check if last timer has been stopped by user. Then remove alertview
        var notZeroIndices: [Int] = []
        for egg in eggs {
            if egg.amount > 0 {
                notZeroIndices.append(egg.desiredEggType.place)
            }
        }

        let highestIndex = notZeroIndices.sorted() { $0 > $1 }[0]
        if highestIndex == index {
            sessionIsactive = false
            player?.stop()
            player = nil
            NotificationManager.shared.cancelAllPendingNotifications()
            invalidateAllTimers()
        }
    }

    @objc func startTimers() {

        sessionIsactive = true
        setupNotificationOnEnteringBackground()
        setupNotificationOnEnteringForeground()
        startAvailableTimers()
        scheduleNotifications()
        startTimerBtn.alpha = 0
        self.navigationItem.hidesBackButton = true
        cancelButton.isEnabled = true
        infoImagview.isHidden = true
    }

    func playSound(file: String, ext: String, playForever: Bool) {
        if player != nil {
            player?.stop()
            player = nil
        }

        guard let file: URL = Bundle.main.url(forResource: file, withExtension: ext) else {
            print("error")
            return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: file)

            //guard let player = player else { return }
            if playForever {
                player?.numberOfLoops = -1
            } else {
                player?.numberOfLoops = 0
            }
            player?.play()
        } catch {
            print("The audio file does not exist")
            return
        }
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        player?.stop()
        player = nil
        invalidateAllTimers()
        NotificationManager.shared.cancelAllPendingNotifications()
        self.navigationController?.popToViewController(navigationController?.viewControllers[1] as! SettingsVC, animated: true)
    }

    //MARK: - Fuctions to kill timer
    @IBAction func zachtDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: zachtLbl, timerLbl: zachtTimerLbl, btn: zachtDoneBtn, index: 0)
        timerZacht.invalidate()
        player?.stop()
        player = nil
        removeAlertInStackview(label: zeerZachtAlertLabel)
    }
    @IBAction func zmDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: zmLbl, timerLbl: zmTimerLbl, btn: zmDoneButton, index: 1)
        timerzm.invalidate()
        player?.stop()
        player = nil
        removeAlertInStackview(label: zachtAlertLabel)
    }
    @IBAction func mediumDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: mediumLbl, timerLbl: mediumTimerLbl, btn: mediumDoneBtn, index: 2)
        timermedium.invalidate()
        player?.stop()
        player = nil
        removeAlertInStackview(label: mediumAlertLabel)
    }
    @IBAction func mhDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: mhLbl, timerLbl: mhTimerLbl, btn: mhDoneBtn, index: 3)
        timermh.invalidate()
        player?.stop()
        player = nil
        removeAlertInStackview(label: mediumHardAlertLabel)

    }
    @IBAction func hardDoneBtnPressed(_ sender: Any) {
        setViewsOnStoptimer(lbl: hardLbl, timerLbl: hardTimerLbl, btn: hardDoneBtn, index: 4)
        timerHard.invalidate()
        player?.stop()
        player = nil
        removeAlertInStackview(label: hardAlertLabel)
    }
}
