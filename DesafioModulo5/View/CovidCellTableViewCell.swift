//
//  CovidCellTableViewCell.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 14/08/23.
//

import UIKit

class CovidCellTableViewCell: UITableViewCell {

    let labelCountry = UILabel()
    let labelCasosDiarios = UILabel()
    let labelMuertes = UILabel()
    let labelMuertesTitle = UILabel()
    var ivBandera = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Este seria como el viewDidload
    func start(){
        self.initialComponents()
    }
    
    
    func initialComponents() {
        //ImageView Bandera
        ivBandera.contentMode = .scaleAspectFit
        ivBandera.layer.shadowColor = UIColor.black.cgColor
        ivBandera.layer.shadowOpacity = 0.5
        ivBandera.layer.shadowOffset = CGSize(width: 1, height: 5)
        ivBandera.layer.shadowRadius = 4
        ivBandera.layer.cornerRadius = 20
        ivBandera.clipsToBounds = true
        ivBandera.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ivBandera)
        //Label Country
        labelCountry.textColor = .black
        labelCountry.textAlignment = .left
        labelCountry.backgroundColor = .systemGray6
        labelCountry.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelCountry)
        //Label Casos Diarios
        labelCasosDiarios.textColor = .black
        labelCasosDiarios.textAlignment = .left
        labelCasosDiarios.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelCasosDiarios)
        //Label Muertes title
        labelMuertesTitle.textColor = .black
        labelMuertesTitle.textAlignment = .left
        labelMuertesTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelMuertesTitle)
        //Label Muertes Diarias
        labelMuertes.textColor = .black
        labelMuertes.textAlignment = .left
        labelMuertes.font = UIFont(name: "Arial Bold", size: 20)
        labelMuertes.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelMuertes)
        
        
        NSLayoutConstraint.activate([
            ivBandera.widthAnchor.constraint(equalToConstant: 100),
            ivBandera.heightAnchor.constraint(equalToConstant: 100),
            ivBandera.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ivBandera.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            ivBandera.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            labelCountry.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            labelCountry.leadingAnchor.constraint(equalTo: ivBandera.trailingAnchor, constant: 20),
            labelCountry.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            labelCasosDiarios.topAnchor.constraint(equalTo: labelCountry.bottomAnchor, constant: 10),
            labelCasosDiarios.leadingAnchor.constraint(equalTo: ivBandera.trailingAnchor, constant: 20),
            labelCasosDiarios.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            labelMuertesTitle.topAnchor.constraint(equalTo: labelCasosDiarios.bottomAnchor, constant: 10),
            labelMuertesTitle.leadingAnchor.constraint(equalTo: ivBandera.trailingAnchor, constant: 20),
            labelMuertesTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            labelMuertes.topAnchor.constraint(equalTo: labelCasosDiarios.bottomAnchor, constant: 8.5),
            labelMuertes.leadingAnchor.constraint(equalTo: labelMuertesTitle.trailingAnchor, constant: -130),
            
        ])
    }

}

