//
//  DataModel.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//

import Foundation
import Combine

// MARK: - DataModel

class DataModel: ObservableObject, Identifiable {
    
    @Published var rockets = Rockets()
    
    private var cancellable: AnyCancellable?
    
    private static var decoder : JSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.spacexdata.com/v3/rockets") else {
            fatalError("URL could not be created")
        }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
            .decode(type: Rockets.self, decoder: DataModel.decoder)
        .replaceError(with:[])
        .eraseToAnyPublisher()
        .receive(on: RunLoop.main)
        .assign(to: \.rockets, on: self)
    }
    
    static var exampleRocket: Rocket {
        guard let rocket = try? decoder.decode(Rocket.self, from: jsonRocket.data(using: .utf8)!) else {
            fatalError("Failed to decode \(jsonRocket).")
        }
        return rocket
    }
    
    static let jsonRocket =
        """
        {
        "id": 4,
        "active": false,
        "stages": 2,
        "boosters": 0,
        "cost_per_launch": 7000000,
        "success_rate_pct": 0,
        "first_flight": "2021-12-01",
        "country": "United States",
        "company": "SpaceX",
        "height": {
        "meters": 118,
        "feet": 387
        },
        "diameter": {
        "meters": 9,
        "feet": 30
        },
        "mass": {
        "kg": 2943000,
        "lb": 1335000
        },
        "payload_weights": [
        {
        "id": "leo",
        "name": "Low Earth Orbit",
        "kg": 150000,
        "lb": 330000
        },
        {
        "id": "mars",
        "name": "Mars Orbit",
        "kg": 100000,
        "lb": 220000
        },
        {
        "id": "moon",
        "name": "Moon Orbit",
        "kg": 100000,
        "lb": 220000
        }
        ],
        "first_stage": {
        "reusable": true,
        "engines": 37,
        "fuel_amount_tons": 3300,
        "burn_time_sec": null,
        "thrust_sea_level": {
        "kN": 128000,
        "lbf": 28775544
        },
        "thrust_vacuum": {
        "kN": 138000,
        "lbf": 31023634
        }
        },
        "second_stage": {
        "reusable": true,
        "engines": 6,
        "fuel_amount_tons": 1200,
        "burn_time_sec": null,
        "thrust": {
        "kN": 1957,
        "lbf": 440000
        },
        "payloads": {
        "option_1": "Spaceship",
        "option_2": "composite fairing",
        "composite_fairing": {
        "height": {
        "meters": null,
        "feet": null
        },
        "diameter": {
        "meters": null,
        "feet": null
        }
        }
        }
        },
        "engines": {
        "number": 37,
        "type": "raptor",
        "version": "",
        "layout": null,
        "isp": {
        "sea_level": 330,
        "vacuum": 380
        },
        "engine_loss_max": null,
        "propellant_1": "liquid oxygen",
        "propellant_2": "liquid methane",
        "thrust_sea_level": {
        "kN": 1780,
        "lbf": 400000
        },
        "thrust_vacuum": {
        "kN": 1960,
        "lbf": 440000
        },
        "thrust_to_weight": 107
        },
        "landing_legs": {
        "number": 6,
        "material": "stainless steel"
        },
        "flickr_images": [
        "https://instagram.fmad8-1.fna.fbcdn.net/vp/1c76ba72553707f9b1066888ebf24c24/5E2EFA82/t51.2885-15/e35/s1080x1080/70061045_535978163611221_5090594774081844848_n.jpg?_nc_ht=instagram.fmad8-1.fna.fbcdn.net&_nc_cat=1",
        "https://www.spacex.com/sites/spacex/files/starship_cloud_launch1_moved_morechrome.jpg",
        "https://www.spacex.com/sites/spacex/files/starship_uses.jpg",
        "https://www.spacex.com/sites/spacex/files/starship_mk1_night_v2.jpg",
        "https://instagram.fmad8-1.fna.fbcdn.net/vp/c67d2cb3f905f0a2485fa1164035a02a/5E2BBFF6/t51.2885-15/e35/s1080x1080/70419441_2713546198664768_4765877513825954197_n.jpg?_nc_ht=instagram.fmad8-1.fna.fbcdn.net&_nc_cat=108",
        "https://instagram.fmad8-1.fna.fbcdn.net/vp/961b8536a820d0aab48c738f39b9772d/5E3B33F9/t51.2885-15/e35/s1080x1080/70746427_685731121954090_714212350511846981_n.jpg?_nc_ht=instagram.fmad8-1.fna.fbcdn.net&_nc_cat=110"
        ],
        "wikipedia": "https://en.wikipedia.org/wiki/SpaceX_Starship",
        "description": "Starship and Super Heavy Rocket represent a fully reusable transportation system designed to service all Earth orbit needs as well as the Moon and Mars. This two-stage vehicle — composed of the Super Heavy rocket (booster) and Starship (ship) — will eventually replace Falcon 9, Falcon Heavy and Dragon.",
        "rocket_id": "starship",
        "rocket_name": "Starship",
        "rocket_type": "rocket"
        }
        """
}

