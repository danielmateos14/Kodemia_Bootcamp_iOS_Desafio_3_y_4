//
//  DetallesViewController.swift
//  DesafioModulo5
//
//  Created by danielmateos14 on 16/08/23.
//

import Foundation
import UIKit
import SceneKit

class DetallesViewController: UIViewController {
    
    
    let labelCountry = UILabel()
    let labelContinent = UILabel()
    let labelCasos = UILabel()
    let labelCasosDiarios = UILabel()
    let labelMuertes = UILabel()
    let labelMuertesDiarias = UILabel()
    let labelRecuperados = UILabel()
    var ivBandera = UIImageView()
    var ivCov = UIImageView()
    var labelCovid = UILabel()
    
    let covidViewModel = CovidViewModel()
    
    var country: String
    var continent: String
    var casos: Int
    var casosDiarios: Int
    var muertes: Int
    var muertesDiarias: Int
    var recuperados: Int
    var bandera: String
    
    init(country: String, continent: String, casos: Int, casosDiarios: Int, muertes: Int, muertesTotales: Int, recuperados: Int, bandera: String){
        self.country = country
        self.continent = continent
        self.casos = casos
        self.casosDiarios = casosDiarios
        self.muertes = muertes
        self.muertesDiarias = muertesTotales
        self.recuperados = recuperados
        self.bandera = bandera
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialComponents()
        print(bandera)
    }

    private func initialComponents(){
        view.backgroundColor = .white
        
        //MARK: Transicion
        //ImageView Bandera
        covidViewModel.getImage(recibeFlag: bandera, imagenRetornada: { image in
            DispatchQueue.main.async {
                UIView.transition(with: self.ivBandera, duration: 1.5, options: .transitionCurlDown) {
                    self.ivBandera.image = image
                }
            }
        })
        ivBandera.contentMode = .scaleAspectFit
        ivBandera.layer.shadowColor = UIColor.black.cgColor
        ivBandera.layer.shadowOpacity = 0.5
        ivBandera.layer.shadowOffset = CGSize(width: 1, height: 5)
        ivBandera.layer.shadowRadius = 4
        ivBandera.layer.cornerRadius = 20
        ivBandera.clipsToBounds = true
        ivBandera.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ivBandera)
        //Label Country
        labelCountry.text = "Pais: \(country)"
        labelCountry.textColor = .black
        labelCountry.textAlignment = .left
        labelCountry.font = UIFont(name: "Arial Bold", size: 20)
        labelCountry.backgroundColor = .systemGray6
        labelCountry.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelCountry)
        //Label Continente
        labelContinent.text = "Continente: \(continent)"
        labelContinent.textColor = .black
        labelContinent.textAlignment = .left
        labelContinent.font = UIFont(name: "Arial Bold", size: 20)
        labelContinent.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelContinent)
        //Label Casos
        labelCasos.text = "Casos: \(casos)"
        labelCasos.textColor = .black
        labelCasos.textAlignment = .left
        labelCasos.font = UIFont(name: "Arial Bold", size: 20)
        labelCasos.backgroundColor = .systemGray6
        labelCasos.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelCasos)
        //Label Casos Diarios
        labelCasosDiarios.text = "Casos diarios: \(casosDiarios)"
        labelCasosDiarios.textColor = .black
        labelCasosDiarios.textAlignment = .left
        labelCasosDiarios.font = UIFont(name: "Arial Bold", size: 20)
        labelCasosDiarios.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelCasosDiarios)
        //Label Muertes
        labelMuertes.text = "Muertes: \(muertes)"
        labelMuertes.textColor = .black
        labelMuertes.textAlignment = .left
        labelMuertes.font = UIFont(name: "Arial Bold", size: 20)
        labelMuertes.backgroundColor = .systemGray6
        labelMuertes.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelMuertes)
        //Label Muertes Diarias
        labelMuertesDiarias.text = "Muertes Diarias: \(muertesDiarias)"
        labelMuertesDiarias.textColor = .black
        labelMuertesDiarias.textAlignment = .left
        labelMuertesDiarias.font = UIFont(name: "Arial Bold", size: 20)
        labelMuertesDiarias.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelMuertesDiarias)
        //Label Recuperadops
        labelRecuperados.text = "Recuperados: \(recuperados)"
        labelRecuperados.textColor = .black
        labelRecuperados.textAlignment = .left
        labelRecuperados.font = UIFont(name: "Arial Bold", size: 20)
        labelRecuperados.backgroundColor = .systemGray6
        labelRecuperados.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelRecuperados)
        //Label Covid
        labelCovid.text = "COVID19"
        labelCovid.textColor = .red
        labelCovid.textAlignment = .left
        labelCovid.font = UIFont(name: "Arial Bold", size: 40)
        labelCovid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelCovid)

        
        //ImageView Covid
        ivCov.image = UIImage(named: "")
        ivCov.contentMode = .scaleAspectFit
        ivCov.layer.shadowColor = UIColor.red.cgColor
        ivCov.layer.shadowOpacity = 0.5
        ivCov.layer.shadowOffset = CGSize(width: 1, height: 5)
        ivCov.layer.shadowRadius = 4
        ivCov.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ivCov)
        
        //MARK: 3D
        startRotatingView(view: ivCov)
        
        
        
        //Constraints
        NSLayoutConstraint.activate([
            ivBandera.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            ivBandera.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ivBandera.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ivBandera.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            
            labelCountry.topAnchor.constraint(equalTo: ivBandera.bottomAnchor, constant: 20),
            labelCountry.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelCountry.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelContinent.topAnchor.constraint(equalTo: labelCountry.bottomAnchor, constant: 10),
            labelContinent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelContinent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelCasos.topAnchor.constraint(equalTo: labelContinent.bottomAnchor, constant: 10),
            labelCasos.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelCasos.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelCasosDiarios.topAnchor.constraint(equalTo: labelCasos.bottomAnchor, constant: 10),
            labelCasosDiarios.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelCasosDiarios.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelMuertes.topAnchor.constraint(equalTo: labelCasosDiarios.bottomAnchor, constant: 10),
            labelMuertes.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelMuertes.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelMuertesDiarias.topAnchor.constraint(equalTo: labelMuertes.bottomAnchor, constant: 10),
            labelMuertesDiarias.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelMuertesDiarias.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelRecuperados.topAnchor.constraint(equalTo: labelMuertesDiarias.bottomAnchor, constant: 10),
            labelRecuperados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelRecuperados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelCovid.topAnchor.constraint(equalTo: labelRecuperados.bottomAnchor, constant: 30),
            labelCovid.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            labelCovid.trailingAnchor.constraint(equalTo: ivCov.trailingAnchor, constant: -20),
            
            ivCov.widthAnchor.constraint(equalToConstant: 50),
            ivCov.heightAnchor.constraint(equalToConstant: 50),
            ivCov.topAnchor.constraint(equalTo: labelRecuperados.bottomAnchor, constant: 20),
            ivCov.leadingAnchor.constraint(equalTo: labelCovid.leadingAnchor, constant: 16),
            ivCov.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100),
            ivCov.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
        
        func crearBandera(){
            // URL de la imagen
            let imageUrlString = bandera
            
            // Descarga la imagen desde la URL
            if let imageUrl = URL(string: imageUrlString) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                    if let imageData = data, let image = UIImage(data: imageData) {
                        // Actualiza la imagen en el hilo principal
                        DispatchQueue.main.async {
                            self?.ivBandera.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    
    //MARK: 3D
    func startRotatingView(view: UIView) {
        // Crea la vista de SceneKit
        let sceneView = SCNView(frame: CGRect(x: 165, y: 395, width: 230, height: 230))
        sceneView.backgroundColor = UIColor.clear
        self.view.addSubview(sceneView)
        
        // Crea una escena
        let scene = SCNScene()
        sceneView.scene = scene
        
        // Crea una cámara
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0.5, y: 3, z: 8.0)
        
        // Crea una esfera
        let sphereGeometry = SCNSphere(radius: 1.0)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        
        // Carga la imagen que deseas aplicar a la esfera
        let imageMaterial = SCNMaterial()
        let material = SCNMaterial()
        imageMaterial.diffuse.contents = UIImage(named: "cov") // Reemplaza "nombre_de_tu_imagen" con el nombre de tu imagen
        material.diffuse.contents = UIColor.red
        sphereGeometry.materials = [imageMaterial, material] //agregar los materiales
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(sphereNode)
        
        // Agrega rotación a la esfera
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 4.0)
        let repeatRotation = SCNAction.repeatForever(rotation)
        sphereNode.runAction(repeatRotation)
    }
}
