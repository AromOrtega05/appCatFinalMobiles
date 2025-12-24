//
//  Extension+BreedListViewController+SearchBar.swift
//  UNO
//
//  Created by Suite on 20/12/25.
//

//
//  Extension+BreedListViewController+SearchBar.swift
//  UNO
//
//  Created on [fecha actual]
//

import UIKit

// MARK: - UISearchBarDelegate
extension BreedListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredBreeds = breeds
        } else {
            isSearching = true
            filteredBreeds = breeds.filter { breed in
                breed.name.localizedCaseInsensitiveContains(searchText) ||
                breed.origin?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredBreeds = breeds
        tableView.reloadData()
    }
}
