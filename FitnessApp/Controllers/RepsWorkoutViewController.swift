//
//  StartWorkoutViewController.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 26.08.2022.
//

import UIKit

class RepsWorkoutViewController: UIViewController {
    
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
    
    private let sportsmanImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Sportsman")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private let repsWorkoutParametersView = RepsWorkoutParametersView()
    
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
    
    private var numberOfSet = 1
    
    var workoutModel = WorkoutModel()
    
    let customAlert = CustomAlert()
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setConstraints()
        setWorkoutParameters()
        setDelegates()
}
    
    private func setDelegates() {
        repsWorkoutParametersView.cellNextSetDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(sportsmanImageView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(repsWorkoutParametersView)
        scrollView.addSubview(finishButton)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
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
    }
    
    private func setWorkoutParameters() {
        repsWorkoutParametersView.workoutNameLabel.text = workoutModel.workoutName
        repsWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        repsWorkoutParametersView.numberOfRepsLabel.text = "\(workoutModel.workoutReps)"
    }
}

//MARK: - NextSetRepsProtocol

extension RepsWorkoutViewController: NextSetRepsProtocol {
    func editingButtonTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Reps") { [self] sets, reps in
            if sets != "" && reps != "" {
            repsWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(sets)"
            repsWorkoutParametersView.numberOfRepsLabel.text = reps
            guard let numberOfSets = Int(sets) else {return}
            guard let numberOfReps = Int(reps) else {return}
            RealmManager.shared.updateSetsRepsWorkoutModel(model: workoutModel, sets: numberOfSets, reps: numberOfReps)
        }
    }
}
    func nextSetRepsTapped() {
        
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            repsWorkoutParametersView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Error", message: "Finish your excercise")
        }
    }
}

//MARK: - SetConstraints
extension RepsWorkoutViewController {
    
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
            sportsmanImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            sportsmanImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 10),
            sportsmanImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            sportsmanImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: sportsmanImageView.bottomAnchor, constant: 10),
            detailsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            detailsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            repsWorkoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            repsWorkoutParametersView.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            repsWorkoutParametersView.trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor),
            repsWorkoutParametersView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: repsWorkoutParametersView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: detailsLabel.leadingAnchor),
            finishButton.trailingAnchor.constraint(equalTo: detailsLabel.trailingAnchor),
            finishButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            finishButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
}
}
