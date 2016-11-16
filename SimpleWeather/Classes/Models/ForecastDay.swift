//
//  ForecastDay.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/14/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ForecastDay {

    struct Wind {
        let speed: Int
        let direction: String

        init?(json: [String: Any]) {
            guard let mph = json["mph"] as? Int,
                let dir = json["dir"] as? String
                else { return nil }
            self.speed = mph
            self.direction = dir
        }
    }

    let date: Date
    let high: Int
    let low: Int
    let conditions: String
    let pop: Double
    let qpf_allday: Double
    let qpf_day: Double
    let qpf_night: Double
    let snow_allday: Double
    let snow_day: Double
    let snow_night: Double
    let icon: ConditionsIcon
    let avehumidity: Int
    let maxhumidity: Int
    let minhumidity: Int

    let max_wind: Wind?
    let average_wind: Wind?

    init?(json: [String: Any]) {
        guard let epoch_string = keypath(dict: json, path: "date.epoch") as String?,
            let date_interval = TimeInterval(epoch_string),
            let high = (keypath(dict: json, path: "high.fahrenheit") as NSString?)?.integerValue,
            let low = (keypath(dict: json, path: "low.fahrenheit") as NSString?)?.integerValue,
            let conditions = json["conditions"] as? String,
            let pop = json["pop"] as? Int,
            let qpf_allday = keypath(dict: json, path: "qpf_allday.in") as Double?,
            let qpf_day = keypath(dict: json, path: "qpf_day.in") as Double?,
            let qpf_night = keypath(dict: json, path: "qpf_night.in") as Double?,
            let snow_allday = keypath(dict: json, path: "snow_allday.in") as Double?,
            let snow_day = keypath(dict: json, path: "snow_day.in") as Double?,
            let snow_night = keypath(dict: json, path: "snow_night.in") as Double?,
            let icon_name = json["icon"] as? String,
            let avewind_json = json["avewind"] as? [String: Any],
            let maxwind_json = json["maxwind"] as? [String: Any],
            let avehumidity = json["avehumidity"] as? Int,
            let maxhumidity = json["maxhumidity"] as? Int,
            let minhumidity = json["minhumidity"] as? Int
            else { return nil }

        self.date = Date(timeIntervalSince1970: date_interval)
        self.max_wind = Wind(json: maxwind_json)
        self.average_wind = Wind(json: avewind_json)
        self.high = high
        self.low = low
        self.conditions = conditions
        self.pop = Double(pop) / 100.0
        self.qpf_allday = qpf_allday
        self.qpf_day = qpf_day
        self.qpf_night = qpf_night
        self.snow_allday = snow_allday
        self.snow_day = snow_day
        self.snow_night = snow_night
        self.avehumidity = avehumidity
        self.maxhumidity = maxhumidity
        self.minhumidity = minhumidity
        self.icon = ConditionsIcon.from(string: icon_name)
    }
    
}