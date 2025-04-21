//
//  ViewController.swift
//  StudyTimer
//
//  Created by Suhaas Achanta on 4/19/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Timer Properties
    var timer: Timer?
    var isRunning = false
    var isFocusMode = true
    var timeLeft: TimeInterval = TimerSettings.workDuration
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) Force dark style
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        
        // 2) Style labels
        modeLabel.font = .systemFont(ofSize: 24, weight: .bold)
        modeLabel.textColor = .white
        modeLabel.text = "Focus Mode"
        
        timerLabel.font = .systemFont(ofSize: 32, weight: .bold)
        timerLabel.textColor = .white
        
        // 3) Style Start/Pause button
        startPauseButton.setTitleColor(.white, for: .normal)
        startPauseButton.backgroundColor = .systemBlue
        startPauseButton.layer.cornerRadius = 8
        
        // ————— Beefy shadow for Start/Pause —————
        startPauseButton.layer.masksToBounds = false
        startPauseButton.layer.shadowColor   = UIColor.black.cgColor
        startPauseButton.layer.shadowOpacity = 0.5
        startPauseButton.layer.shadowOffset  = CGSize(width: 0, height: 4)
        startPauseButton.layer.shadowRadius  = 8
        startPauseButton.layer.shadowPath    = UIBezierPath(
            roundedRect: startPauseButton.bounds,
            cornerRadius: startPauseButton.layer.cornerRadius
        ).cgPath
        
        // 4) Style Reset button
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .darkGray
        resetButton.layer.cornerRadius = 8
        
        // ————— Subtle shadow for Reset —————
        resetButton.layer.masksToBounds = false
        resetButton.layer.shadowColor   = UIColor.black.cgColor
        resetButton.layer.shadowOpacity = 0.4
        resetButton.layer.shadowOffset  = CGSize(width: 0, height: 2)
        resetButton.layer.shadowRadius  = 6
        resetButton.layer.shadowPath    = UIBezierPath(
            roundedRect: resetButton.bounds,
            cornerRadius: resetButton.layer.cornerRadius
        ).cgPath
        
        // 5) Prepare ring and label
        setupProgressRing()
        updateTimerLabel()
    }


    
    // MARK: - Ring Setup
    func setupProgressRing() {
        let size = progressView.bounds.size
        let center = CGPoint(x: size.width/2, y: size.height/2)
        let radius = min(size.width, size.height)/2 - 10
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -.pi/2,
            endAngle: 1.5 * .pi,
            clockwise: true
        )
        
        // Track layer (gray background ring)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.darkGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        progressView.layer.addSublayer(trackLayer)
        
        // Progress layer (blue foreground ring)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0
        progressView.layer.addSublayer(progressLayer)
    }
    
    // MARK: - Helpers
    func updateTimerLabel() {
        let m = Int(timeLeft) / 60
        let s = Int(timeLeft) % 60
        timerLabel.text = String(format: "%02d:%02d", m, s)
    }
    
    func updateProgressRing() {
        let total = isFocusMode
            ? TimerSettings.workDuration
            : TimerSettings.breakDuration
        let progress = 1 - (timeLeft / total)
        progressLayer.strokeEnd = CGFloat(progress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      // Reset the countdown to whatever mode we're in
      timeLeft = isFocusMode
        ? TimerSettings.workDuration
        : TimerSettings.breakDuration
      
      // Reset UI
      updateTimerLabel()
      updateProgressRing()
      startPauseButton.setTitle("Start", for: .normal)
      isRunning = false
    }

    
    // MARK: - Actions
    @IBAction func didTapStartPause(_ sender: UIButton) {
        if isRunning {
            timer?.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
        } else {
            startPauseButton.setTitle("Pause", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.timeLeft -= 1
                self.updateTimerLabel()
                self.updateProgressRing()
                
                if self.timeLeft <= 0 {
                    self.timer?.invalidate()
                    self.isFocusMode.toggle()
                    self.modeLabel.text = self.isFocusMode ? "Focus Mode" : "Break Mode"
                    self.timeLeft = self.isFocusMode
                        ? TimerSettings.workDuration
                        : TimerSettings.breakDuration
                    self.updateTimerLabel()
                    self.updateProgressRing()
                    self.startPauseButton.setTitle("Start", for: .normal)
                    self.isRunning = false
                }
            }
        }
        isRunning.toggle()
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        timer?.invalidate()
        isRunning = false
        timeLeft = isFocusMode
            ? TimerSettings.workDuration
            : TimerSettings.breakDuration
        updateTimerLabel()
        updateProgressRing()
        startPauseButton.setTitle("Start", for: .normal)
    }
}


