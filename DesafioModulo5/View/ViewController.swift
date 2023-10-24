//
//  ViewController.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 14/08/23.
//

import UIKit

class ViewController: UIViewController {

    var country: String?
    var continent: String?
    var casos: Int?
    var casosDiarios: Int?
    var muertes: Int?
    var muertesDiarias: Int?
    var recuperados: Int?
    var bandera: String?
    
    private var covidViewModel = CovidViewModel()
    private var kvoObservation: [NSKeyValueObservation] = []
    
    let labelTitle = UILabel()
    let tableViewCovid = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var objetoCovid: [ObjetoCovidModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewCovid.register(CovidCellTableViewCell.self, forCellReuseIdentifier: "cell")
        covidViewModel.getCovidData()
        observations()
        initialComponents()
        
    }
    
    func initialComponents(){
        //Activity Indicator
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        //Label Title
        labelTitle.text = "Estadisticas COVID"
        labelTitle.textColor = .red
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont(name: "Arial Bold", size: 20)
        labelTitle.layer.shadowColor = UIColor.red.cgColor
        labelTitle.layer.shadowOpacity = 0.5
        labelTitle.layer.shadowOffset = CGSize(width: 1, height: 3)
        labelTitle.layer.shadowRadius = 4
        labelTitle.layer.cornerRadius = 20
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelTitle)
        
        //Table View
        
        tableViewCovid.dataSource = self
        tableViewCovid.delegate = self
        tableViewCovid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableViewCovid)
        
        //Constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableViewCovid.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            tableViewCovid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableViewCovid.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableViewCovid.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func observations() {
        let kvoUserMuertesObservation = covidViewModel.observe(\.muertes, options: [.new]) { [weak self] viewModel, change in
            DispatchQueue.main.async {
                self?.objetoCovid = viewModel.objetoCovid
                self?.tableViewCovid.reloadData()
            }
        }
        kvoObservation = [kvoUserMuertesObservation]
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objetoCovid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewCovid.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CovidCellTableViewCell else {return UITableViewCell()}
        cell.start()
        
        guard (objetoCovid[indexPath.row].countryInfo?.flag) != nil else {
           fatalError("Error al obtener bandera")
        }
        
        //MARK: Transicion
        covidViewModel.getImage(recibeFlag: objetoCovid[indexPath.row].countryInfo?.flag ?? "", imagenRetornada: { image in
            DispatchQueue.main.async {
                UIView.transition(with: cell.ivBandera, duration: 1.5, options: .transitionFlipFromRight) {
                    cell.ivBandera.image = image
                }
            }
        })
        
        cell.labelCountry.text = "País: \(objetoCovid[indexPath.row].country)"
        cell.labelCasosDiarios.text = "Casos hoy \(objetoCovid[indexPath.row].cases)"
        
        cell.labelMuertesTitle.text = "Muertes: "
        
        
        cell.labelMuertes.text = "\(objetoCovid[indexPath.row].deaths)"
        cell.labelMuertes.textColor = covidViewModel.changeColorDeath(recibeMuertes: objetoCovid[indexPath.row].deaths)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Presentar la nueva vista
        //Inyeccion de dependencias
        //Crear objeto en la nueva vista y luego aqui pasarle por medio de inyeccion
        let detallesVC = DetallesViewController(country: objetoCovid[indexPath.row].country,
                                                continent: objetoCovid[indexPath.row].continent,
                                                casos: objetoCovid[indexPath.row].cases,
                                                casosDiarios: objetoCovid[indexPath.row].todayCases,
                                                muertes: objetoCovid[indexPath.row].deaths,
                                                muertesTotales: objetoCovid[indexPath.row].todayDeaths,
                                                recuperados: objetoCovid[indexPath.row].todayRecovered,
                                                bandera: objetoCovid[indexPath.row].countryInfo?.flag ?? "")
        detallesVC.modalPresentationStyle = .automatic
        //MARK: Transicion
        detallesVC.modalTransitionStyle = .flipHorizontal
        present(detallesVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

}



