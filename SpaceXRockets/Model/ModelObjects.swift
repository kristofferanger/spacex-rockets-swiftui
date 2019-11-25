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
    let flickrImages: [String]
    let wikipedia: String
    let rocketDescription: String
    let rocketId: String
    let rocketName: String
    let rocketType: String

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
    let fuelAmountTons: Double
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
    let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
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
    let compositeFairing: CompositeFairing
    let option2: String?

    enum CodingKeys: String, CodingKey {
        case option1
        case compositeFairing
        case option2
    }
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable {
    let height: Diameter
    let diameter: Diameter
}
