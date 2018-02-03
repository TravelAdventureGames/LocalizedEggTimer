//
//  TimerVC+timerlogics.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 22-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

extension TimerVC {
    func startAvailableTimers() {
        for egg in eggs {
            if egg.amount != 0 {
                switch egg.desiredEggType {
                case .Soft:
                    runZachtTimer()
                case .SoftMedium:
                    runzmTimer()
                case .Medium:
                    runMediumTimer()
                case .MediumHard:
                    runmhTimer()
                case .Hard:
                    runHardTimer()
                }
            }
        }
    }

    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

    @objc func updateZachtTimer() {
        if zachtDuration < 1 {
            timerZacht.invalidate()
            zachtTimerLbl.shake()
            playSound(file: "eggsready", ext: "wav", playForever: true)
            setDoneBtnUI(btn: zachtDoneBtn)
            presentAlertInStackview(label: zeerZachtAlertLabel, index: 0)
            //alertlabel.text = presentAlert(index: 0)
        } else {
            zachtDuration -= 1
            zachtTimerLbl.text = timeString(time: TimeInterval(zachtDuration))
        }
    }

    @objc func updatezmTimer() {
        if zmDuration < 1 {
            timerzm.invalidate()
            zmTimerLbl.shake()
            playSound(file: "eggsready", ext: "wav", playForever: true)
            setDoneBtnUI(btn: zmDoneButton)
            //alertlabel.text = presentAlert(index: 1)
            presentAlertInStackview(label: zachtAlertLabel, index: 1)
        } else {
            zmDuration -= 1
            zmTimerLbl.text = timeString(time: TimeInterval(zmDuration))
        }
    }

    @objc func updateMediumTimer() {
        if mediumDuration < 1 {
            timermedium.invalidate()
            mediumTimerLbl.shake()
            setDoneBtnUI(btn: mediumDoneBtn)
            playSound(file: "eggsready", ext: "wav", playForever: true)
            //alertlabel.text = presentAlert(index: 2)
            presentAlertInStackview(label: mediumAlertLabel, index: 2)
        } else {
            mediumDuration -= 1
            mediumTimerLbl.text = timeString(time: TimeInterval(mediumDuration))
        }
    }

    @objc func updatemhTimer() {
        if mhDuration < 1 {
            timermh.invalidate()
            mhTimerLbl.shake()
            setDoneBtnUI(btn: mhDoneBtn)
            playSound(file: "eggsready", ext: "wav", playForever: true)
            //alertlabel.text = presentAlert(index: 3)
            presentAlertInStackview(label: mediumHardAlertLabel, index: 3)
        } else {
            mhDuration -= 1
            mhTimerLbl.text = timeString(time: TimeInterval(mhDuration))
        }
    }

    @objc func updateHardTimer() {
        if hardDuration < 1 {
            timerHard.invalidate()
            hardTimerLbl.shake()
            setDoneBtnUI(btn: hardDoneBtn)
            playSound(file: "eggsready", ext: "wav", playForever: true)
            //removealert
            //alertlabel.text = presentAlert(index: 4)
            presentAlertInStackview(label: hardAlertLabel, index: 4)
        } else {
            hardDuration -= 1
            hardTimerLbl.text = timeString(time: TimeInterval(hardDuration))
        }
    }

    private func runZachtTimer() {
        timerZacht = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateZachtTimer), userInfo: nil, repeats: true)
    }
    private func runzmTimer() {
        timerzm = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatezmTimer), userInfo: nil, repeats: true)
    }

    private func runMediumTimer() {
        timermedium = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMediumTimer), userInfo: nil, repeats: true)
    }

    private func runmhTimer() {
        timermh = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatemhTimer), userInfo: nil, repeats: true)
    }

    private func runHardTimer() {
        timerHard = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateHardTimer), userInfo: nil, repeats: true)
    }

}
