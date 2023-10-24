//
//  RequestCovid.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 14/08/23.
//

import Foundation

struct RequestCovid {
    
    func requestCovid(clouserCompletion: @escaping(Result<[CovidModel], Error>) -> Void) {
        guard let url = URL(string: "https://corona.lmao.ninja/v3/covid-19/countries/") else {
            clouserCompletion(.failure(CovidErrors.URLInvalida))
            return
        }
        
        let urlSessions = URLSession.shared
        urlSessions.dataTask(with: url) { data, response, error in
            if let _ = error {
                clouserCompletion(.failure(CovidErrors.urlSessionsError))
            }
            guard let data = data else {
                clouserCompletion(.failure(CovidErrors.DatosInvalidos))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                clouserCompletion(.failure(CovidErrors.responseError))
                return
            }
            guard response.statusCode == 200 else {
                clouserCompletion(.failure(CovidErrors.statusError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let covidObject = try decoder.decode([CovidModel].self, from: data)
                print(covidObject.first?.deaths ?? 0)
                clouserCompletion(.success(covidObject))
            } catch {
                clouserCompletion(.failure(CovidErrors.parseError))
            }
        }.resume()
    }
}


enum CovidErrors: Error {
    case URLInvalida
    case DatosInvalidos
    case urlSessionsError
    case responseError
    case statusError
    case parseError
}
