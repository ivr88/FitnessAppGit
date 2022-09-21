//
//  WeatherModel.swift
//  FitnessApp
//
//  Created by Вадим Исламов on 18.09.2022.
//

import Foundation

struct WeatherModel: Decodable {
    let currently: Currently
}

struct Currently: Decodable {
    let temperature: Double
    let icon: String?
    
    var temperatureCelsius: Int {
        return (Int(temperature) - 32) * 5 / 9
    }
    
    var iconLocal: String {
        switch icon {
        case "clear-day": return "Ясно"
        case "clear-night": return "Ясная ночь"
        case "rain": return "Дождь"
        case "snow": return "Снег"
        case "sleet": return "Мокрый снег"
        case "wind": return "Ветрено"
        case "fog": return "Туман"
        case "cloudy": return "Облачно"
        case "partly-cloudy-day": return "Пасмурный день"
        case "partly-cloudy-night": return "Пасмурная ночь"
        default: return "No data"
        }
    }
    
    var description: String {
        switch icon {
        case "clear-day": return "Ясно"
        case "clear-night": return "Ясная ночь"
        case "rain": return "Дождь"
        case "snow": return "Снег"
        case "sleet": return "Мокрый снег"
        case "wind": return "Ветрено"
        case "fog": return "Туман"
        case "cloudy": return "На улице ночь и тучи! Тренируйся дома!"
        case "partly-cloudy-day": return "Пасмурный день"
        case "partly-cloudy-night": return "Пасмурная ночь"
        default: return "No data"
        }
    }
}
