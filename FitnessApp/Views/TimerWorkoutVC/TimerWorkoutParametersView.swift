//
//  TimerWorkoutParametersView.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 31.08.2022.
//

import UIKit

protocol NextSetTimerProtocol: AnyObject {
    func nextSetTapped()
    func editingButtonTapped()
}

class TimerWorkoutParametersView: UIView {
    
    let workoutNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.tintColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setsLabel: UILabel = {
       let label = UILabel()
        label.text = "Sets"
        label.tintColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfSetsLabel: UILabel = {
       let label = UILabel()
        label.text = "1/4"
        label.tintColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setsLineView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeOfSetLabel: UILabel = {
       let label = UILabel()
        label.text = "Time Of Set"
        label.tintColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = "1 min 30 sec"
        label.tintColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLineView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialLightBrown
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.tintColor = .specialGray
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
        button.setTitle("NEXT SET", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var setsStackView = UIStackView()
    var timerStackView = UIStackView()
    
    weak var cellNextSetDelegate: NextSetTimerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(workoutNameLabel)
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        setsStackView.distribution = .equalSpacing
        addSubview(setsStackView)
        addSubview(setsLineView)
        
        timerStackView = UIStackView(arrangedSubviews: [timeOfSetLabel, timeLabel],
                                   axis: .horizontal,
                                   spacing: 10)
        timerStackView.distribution = .equalSpacing
        addSubview(timeLineView)
        addSubview(timerStackView)
        addSubview(editingButton)
        addSubview(nextSetButton)
        
    }
    
    @objc func editingButtonTapped() {
        cellNextSetDelegate?.editingButtonTapped()
    }
    
    @objc func nextSetsButtonTapped() {
        cellNextSetDelegate?.nextSetTapped()
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 2),
            setsLineView.leadingAnchor.constraint(equalTo: setsStackView.leadingAnchor),
            setsLineView.trailingAnchor.constraint(equalTo: setsStackView.trailingAnchor),
            setsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: setsStackView.leadingAnchor),
            timerStackView.trailingAnchor.constraint(equalTo: setsStackView.trailingAnchor),
            timerStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            timeLineView.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 2),
            timeLineView.leadingAnchor.constraint(equalTo: setsStackView.leadingAnchor),
            timeLineView.trailingAnchor.constraint(equalTo: setsStackView.trailingAnchor),
            timeLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: timeLineView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: setsStackView.trailingAnchor),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            editingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetButton.trailingAnchor.constraint(equalTo: setsStackView.trailingAnchor),
            nextSetButton.leadingAnchor.constraint(equalTo: setsStackView.leadingAnchor),
            nextSetButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
