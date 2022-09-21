//
//  StatisticsTableViewCell.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 05.09.2022.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    private let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.font = .robotoMedium24()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameWorkoutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGray
        label.font = .robotoBold20()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutBeforeLabel = UILabel(text: "Before: 18")
    
    private let workoutNowLabel = UILabel(text: "After: 20")
    
    var stackView = UIStackView()
    
    private let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(differenceLabel)
        addSubview(nameWorkoutLabel)
        
        stackView = UIStackView(arrangedSubviews: [workoutBeforeLabel, workoutNowLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        
        addSubview(stackView)
        addSubview(lineView)
    }
    
    func cellConfigure (differenceWorkout: DifferenceWorkout) {
        nameWorkoutLabel.text = differenceWorkout.name
        workoutBeforeLabel.text = "Before: \(differenceWorkout.firstReps)"
        workoutNowLabel.text = "Now: \(differenceWorkout.lastReps)"
        
        let difference = differenceWorkout.lastReps - differenceWorkout.firstReps
        differenceLabel.text = "\(difference)"
        
        switch difference {
        case ..<0: differenceLabel.textColor = .specialGreen
        case 1...: differenceLabel.textColor = .specialDarkYellow
        default:
            differenceLabel.textColor = .specialGray
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            differenceLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameWorkoutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameWorkoutLabel.trailingAnchor.constraint(equalTo: differenceLabel.leadingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameWorkoutLabel.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: nameWorkoutLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
