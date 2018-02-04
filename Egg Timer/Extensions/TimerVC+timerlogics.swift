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
                    if !zachtTimerExpired {
                        runZachtTimer()
                    }
                case .SoftMedium:
                    if !zmTimerExpired {
                        runzmTimer()
                    }
                case .Medium:
                    if !mediumTimerExpired {
                        runMediumTimer()
                    }
                case .MediumHard:
                    if !mhTimerExpired {
                        runmhTimer()
                    }
                case .Hard:
                    if !hardTimerExpired {
                        runHardTimer()
                    }
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
            zachtDoneBtn.alpha = 1
            zachtTimerExpired = true
            presentAlertInStackview(label: zeerZachtAlertLabel, index: 0)
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
            zmDoneButton.alpha = 1
            zmTimerExpired = true
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
            mediumDoneBtn.alpha = 1
            mediumTimerExpired = true
            playSound(file: "eggsready", ext: "wav", playForever: true)
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
            mhDoneBtn.alpha = 1
            playSound(file: "eggsready", ext: "wav", playForever: true)
            mhTimerExpired = true
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
            hardDoneBtn.alpha = 1
            playSound(file: "eggsready", ext: "wav", playForever: true)
            hardTimerExpired = true
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
