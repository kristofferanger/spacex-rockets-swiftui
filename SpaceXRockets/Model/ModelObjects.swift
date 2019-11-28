//
//  ModelObjects.swift
//  SpaceXRockets
//
//  Created by Kristoffer Anger on 2019-11-25.
//  Copyright © 2019 Kriang. All rights reserved.
//


// MARK: - Rocket

import Foundation

typealias Rockets = [Rocket]

struct Rocket: Codable, Identifiable {
    let id: Int
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: Date
    let country: String
    let company: String
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let flickrImages: Array<String>
    let wikipedia: String
    let rocketDescription: String
    let rocketId: String
    let rocketName: String
    let rocketType: String
    
    // computed properties
    var firstLaunchString: String {
        return "First launch: " + dateFormatter.string(from: self.firstFlight)
    }
    
    var heightString: String {
        guard let meters = self.height.meters else {
            return "Unknown"
        }
        return String(format:"%.1f m", meters)
    }
    
    var weightString: String {
        guard let weigth =  self.mass.kg else {
            return "Unknown"
        }
        return String(format:"%.1f t", Double(weigth)/1000)
    }
    
    var diameterString: String {
        guard let meter =  self.diameter.meters else {
            return "Unknown"
        }
        return String(format:"%.1f m", meter)
    }
    
    var propellantCapacityString: String {
        guard let tonsFirst = self.secondStage.fuelAmountTons, let tonsSecond = self.firstStage.fuelAmountTons else {
            return "Unknown"
        }
        return String(format:"%.0f t", tonsFirst + tonsSecond)
    }

    // coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case active
        case stages
        case boosters
        case costPerLaunch
        case successRatePct
        case firstFlight
        case country
        case company
        case height
        case diameter
        case mass
        case payloadWeights
        case firstStage
        case secondStage
        case engines
        case landingLegs
        case flickrImages
        case wikipedia
        case rocketDescription = "description"
        case rocketId
        case rocketName
        case rocketType
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters: Double?
    let feet: Double?
}

// MARK: - Engines
struct Engines: Codable {
    let number: Int
    let type: String
    let version: String
    let layout: String?
    let isp: ISP
    let engineLossMax: Int?
    let propellant1: String
    let propellant2: String
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        case number, type, version, layout, isp
        case engineLossMax
        case propellant1
        case propellant2
        case thrustSeaLevel
        case thrustVacuum
        case thrustToWeight
    }
}

// MARK: - ISP
struct ISP: Codable {
    let seaLevel: Int
    let vacuum: Int

    enum CodingKeys: String, CodingKey {
        case seaLevel
        case vacuum
    }
}

// MARK: - Thrust
struct Thrust: Codable {
    let kN, lbf: Int
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double?
    let burnTimeSEC: Int?
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let cores: Int?

    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelAmountTons
        case burnTimeSEC
        case thrustSeaLevel
        case thrustVacuum
        case cores
    }
}

// MARK: - LandingLegs
struct LandingLegs: Codable {
    let number: Int
    let material: String?
}

// MARK: - Mass
struct Mass: Codable {
    let kg: Int?
    let lb: Int?
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double?
    let burnTimeSEC: Int?
    let thrust: Thrust
    let payloads: Payloads

    enum CodingKeys: String, CodingKey {
        case reusable
        case engines
        case fuelAmountTons
        case burnTimeSEC
        case thrust
        case payloads
    }
}

// MARK: - Payloads
struct Payloads: Codable {
    let option1: String
    let option2: String?
    let compositeFairing: CompositeFairing

    enum CodingKeys: String, CodingKey {
        case option1
        case option2
        case compositeFairing
    }
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable {
    let height: Diameter
    let diameter: Diameter
}
