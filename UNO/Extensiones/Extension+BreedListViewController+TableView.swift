//
//  Extension+BreedListViewController+TableView.swift
//  UNO
//
//  Created by Suite on 20/12/25.
//

//
//  Extension+BreedListViewController+TableView.swift
//  UNO
//
//  Created on [fecha actual]
//

import UIKit

// MARK: - UITableViewDataSource
extension BreedListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = filteredBreeds.count
        
        // Mostrar estado vacío
        if count == 0 && loadingView.isHidden {
            let emptyLabel = UILabel(frame: tableView.bounds)
            
            // USANDO TUS SETTERS:
            emptyLabel.setText(isSearching ? "No se encontraron resultados" : "No hay razas disponibles")
            emptyLabel.setAlignment(.center)
            
            // Reemplazo de styleAsBody():
            emptyLabel.setFontSize(16)
            emptyLabel.setColor(.secondaryLabel)
            emptyLabel.setLinesFree()
            
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BreedTableViewCell.identifier,
            for: indexPath
        ) as? BreedTableViewCell else {
            return UITableViewCell()
        }
        
        let breed = filteredBreeds[indexPath.row]
        cell.configure(with: breed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

// MARK: - UITableViewDelegate
extension BreedListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let breed = filteredBreeds[indexPath.row]
        
        let detailVC = BreedDetailViewController(nibName: "BreedDetailViewController", bundle: nil)
        detailVC.breed = breed
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
