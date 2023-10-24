//
//  CovidModel.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 14/08/23.


import Foundation

struct CovidModel: Codable {
    let updated: Int
    let country: String
    let countryInfo: CountryInfo?
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let todayRecovered: Int
    let active: Int
    let critical: Int
    let continent: String
}

struct CountryInfo: Codable {
    let flag: String
}

