//
//  BreedDetailViewController.swift
//  UNO
//
//  Created by Suite on 19/12/25.
//

import UIKit

class BreedDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var breed: Breed?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Usando extensión de UIView
        view.setBackgroundColor(.systemBackground)
        title = breed?.name ?? "Detalles"
        
        // --- 1. CONFIGURAR IMAGEN (Usando tu extensión) ---
        // Esto reemplaza contentMode, clipsToBounds, cornerRadius, border, etc.
        breedImageView.styleAsBreedImage()
        breedImageView.setBackgroundColor(.systemGray6)
        
        // --- 2. CONFIGURAR LABELS (Usando tus setters) ---
        
        // Nombre
        nameLabel.setBoldFontSize(24)
        nameLabel.setColor(.label)
        
        // Origen
        originLabel.setFontSize(14)
        originLabel.setColor(.secondaryLabel)
        
        // Descripción
        descriptionLabel.setFontSize(13)
        descriptionLabel.setColor(.label)
        descriptionLabel.setNumberOfLines(3)
        
        // Temperamento
        temperamentLabel.setFontSize(12)
        temperamentLabel.setColor(.secondaryLabel)
        temperamentLabel.setNumberOfLines(2)
        
        // Esperanza de vida y Peso
        lifeSpanLabel.setFontSize(12)
        lifeSpanLabel.setColor(.secondaryLabel)
        
        weightLabel.setFontSize(12)
        weightLabel.setColor(.secondaryLabel)
        
        // --- 3. ACTIVITY INDICATOR (Usando tu extensión) ---
        activityIndicator.setColor(.systemOrange)
        activityIndicator.stopLoading() // Esto hace stopAnimating y isHidden = true
    }
    
    // MARK: - Configure
    private func configure() {
        guard let breed = breed else { return }
        
        // Usando extensión .setText() para todo
        nameLabel.setText(breed.name)
        originLabel.setText("📍 \(breed.origin ?? "Desconocido")")
        descriptionLabel.setText(breed.description ?? "Sin descripción disponible")
        temperamentLabel.setText("💭 Temperamento: \(breed.temperament ?? "Desconocido")")
        lifeSpanLabel.setText("⏱ Esperanza de vida: \(breed.displayLifeSpan) años")
        weightLabel.setText("⚖️ Peso: \(breed.displayWeight) kg")
        
        breedImageView.loadImageWithIndicator(from: breed.imageURL)
        
    }
}
