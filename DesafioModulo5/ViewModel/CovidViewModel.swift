//
//  CovidViewModel.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 14/08/23.
//

import Foundation
import UIKit

class CovidViewModel: NSObject {
    

    @objc dynamic var muertes: Int = 0
    
    private var requestCovid = RequestCovid()
    
    var loader: (() -> ())?
    
    var objetoCovid: [ObjetoCovidModel] = []
    
    func getCovidData(){
        requestCovid.requestCovid { [weak self] resultado in
            switch resultado {
            case .success(let covidResponse):
                self?.objetoCovid = self?.changeModelToObjectCovid(recibeCovidResponse: covidResponse) ?? []
                self?.muertes = covidResponse.first?.deaths ?? 0
            case .failure(let error):
                print("Error -> \(error)")
            }
        }
    }
    
    func changeModelToObjectCovid(recibeCovidResponse : [CovidModel]) -> [ObjetoCovidModel] {
        var objetoCovid: [ObjetoCovidModel] = []
        for data in recibeCovidResponse {
            objetoCovid.append(ObjetoCovidModel(country: data.country, countryInfo: data.countryInfo, cases: data.cases, todayCases: data.todayCases, deaths: data.deaths, todayDeaths: data.todayDeaths, continent: data.continent, todayRecovered: data.todayRecovered))
        }
        
        return objetoCovid
    }
    
    func changeColorDeath(recibeMuertes: Int) -> UIColor {
        if recibeMuertes < 5 {
            return .green
        } else if recibeMuertes > 5 && recibeMuertes < 16 {
            return .purple
        } else if recibeMuertes > 16 && recibeMuertes < 31 {
            return .orange
        } else {
            return .red
        }
    }
    
    func getImage(recibeFlag: String, imagenRetornada: @escaping (UIImage) -> Void) {
        if let imageUrl = URL(string: recibeFlag) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    // Actualiza la imagen en el hilo principal
                    imagenRetornada(image)
                }
            }.resume()
        }
    }
}


