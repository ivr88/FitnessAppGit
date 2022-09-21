//
//  WeatherView.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 08.08.2022.
//

import UIKit

class WeatherView: UIView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Cолнечно"
        label.textColor = .specialGray
        label.font = .robotoBold16()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.textColor = .specialGray
        label.font = .robotoMedium12()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadowOnView()
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weatherStatusLabel)
        addSubview(weatherDescriptionLabel)
        addSubview(imageView)
    }
}

extension WeatherView {
    private func setConstraints() {
    
        NSLayoutConstraint.activate([
        
            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 5),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: weatherStatusLabel.leadingAnchor),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherStatusLabel.trailingAnchor)

        ])

        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: weatherStatusLabel.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)

        ])
        
       
    }
}


