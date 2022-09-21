//
//  TimerWorkoutControllerView.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 30.08.2022.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let startWorkoutLabel: UILabel = {
       let label = UILabel()
        label.text = "START WORKOUT"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let circleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let timerWorkoutParametersView = TimerWorkoutParametersView()
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var numberOfSet = 0
    
    var workoutModel = WorkoutModel()
    
    let customAlert = CustomAlert()
    
    let shapeLayer = CAShapeLayer()
    
    var timer = Timer()
    var durationTimer = 10
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setConstraints()
        setWorkoutParameters()
        setDelegates()
        addTaps()
}
    
    private func setDelegates() {
        timerWorkoutParametersView.cellNextSetDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(circleImageView)
        scrollView.addSubview(timerLabel)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(timerWorkoutParametersView)
        scrollView.addSubview(finishButton)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @objc func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        } else {
            okCancelAlert(title: "Warning", message: "You didn't finish your workout") {
                self.dismiss(animated: true)
            }
        }
        
        timer.invalidate()
    }
    
    private func setWorkoutParameters() {
        timerWorkoutParametersView.workoutNameLabel.text = workoutModel.workoutName
        timerWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        
        let (min, sec) = workoutModel.workoutTimer.convertSeconds()
        timerWorkoutParametersView.timeLabel.text = "\(min) min \(sec) sec"
        
        timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
        durationTimer = workoutModel.workoutTimer
    }
    
    private func addTaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        
        timerWorkoutParametersView.editingButton.isEnabled = false
        timerWorkoutParametersView.nextSetButton.isEnabled = false
        
        if numberOfSet == workoutModel.workoutSets {
            alertOK(title: "Error", message: "Finish your excercise")
        } else {
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
}
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            
            numberOfSet += 1
            timerWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
            
            timerWorkoutParametersView.editingButton.isEnabled = true
            timerWorkoutParametersView.nextSetButton.isEnabled = true
        }
        
        let (min, sec) = durationTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
    }
}

//MARK: - NextSetTimerProtocol

extension TimerWorkoutViewController: NextSetTimerProtocol {
    
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            timerWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Error", message: "Finish your excercise")
        }
    }
    
    func editingButtonTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Time of set") { [self] sets, timerOfSet in
            if sets != "" && timerOfSet != "" {
                guard let numberOfSets = Int(sets) else {return}
                guard let numberOfTimer = Int(timerOfSet) else {return}
                let (min, sec) = numberOfTimer.convertSeconds()
                timerWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(sets)"
                timerWorkoutParametersView.timeLabel.text = "\(min) min \(sec) sec"
                timerLabel.text = "\(min):\(sec.setZeroForSeconds())"
                durationTimer = numberOfTimer
                RealmManager.shared.updateSetsTimerWorkoutModel(model: workoutModel,
                                                                sets: numberOfSets,
                                                                timer: numberOfTimer)
        }
     }
   }
}

//MARK: - Animation

extension TimerWorkoutViewController {
    
    private func animationCircular() {
        
        let center = CGPoint(x: circleImageView.frame.width/2, y: circleImageView.frame.height/2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 125,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        circleImageView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

//MARK: - SetConstraints

extension TimerWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            circleImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            circleImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 10),
            circleImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            circleImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: circleImageView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 10),
            detailsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            detailsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            timerWorkoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            timerWorkoutParametersView.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            timerWorkoutParametersView.trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor),
            timerWorkoutParametersView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: timerWorkoutParametersView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            finishButton.trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor),
            finishButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            finishButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
}
}
