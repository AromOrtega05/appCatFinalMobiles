//
//  BreedListViewController.swift
//  UNO
//
//  Created by Suite on 19/12/25.
//

import UIKit

class BreedListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    // MARK: - Properties
    private let breedFetcher = BreedFetcher()
    
    var breeds: [Breed] = []
    var filteredBreeds: [Breed] = []
    var isSearching: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupSearchBar()
        setupFetcher()
        breedFetcher.fetchBreeds()
        setupProfileButton()
    }
    
    // MARK: - Profile Button
    private func setupProfileButton() {
        // Nota: UIBarButtonItem no tiene extensión en tu lista, se queda estándar
        let profileImage = UIImage(systemName: "person.crop.circle")
        let profileButton = UIBarButtonItem(
            image: profileImage,
            style: .plain,
            target: self,
            action: #selector(goToProfile)
        )
        profileButton.tintColor = .label
        navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc private func goToProfile() {
        let profileVC = ProfileViewController(
            nibName: "ProfileViewController",
            bundle: nil
        )
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Find Your Perfect Cat"
        
        // 1. VIEW (Extension)
        view.setBackgroundColor(.systemBackground)
        
        // 2. ERROR LABEL (Extensions)
        errorView.isHidden = true
        errorLabel.setFontSize(16)
        errorLabel.setColor(.secondaryLabel)
        errorLabel.setLinesFree()
        errorLabel.setAlignment(.center)
        
        // 3. RETRY BUTTON (Extensions)
        retryButton.setTitleText("Reintentar")
        retryButton.setBackgroundColor(.systemOrange)
        retryButton.setTitleColor(.white)
        retryButton.setCornerRadius(8)
        // addTarget es estándar de UIControl, no se suele extender
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        // 4. LOADING (Extensions)
        loadingView.isHidden = false
        activityIndicator.setColor(.systemOrange) // Agregado para que combine
        activityIndicator.startLoading()          // Reemplaza startAnimating + isHidden
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Extension
        tableView.setBackgroundColor(.systemGroupedBackground)
        
        let nib = UINib(
            nibName: BreedTableViewCell.nibName,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: BreedTableViewCell.identifier
        )
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refreshData),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Buscar raza..." // SearchBar no tiene extensión en tu lista
        searchBar.searchBarStyle = .minimal
    }
    
    private func setupFetcher() {
        breedFetcher.stateDidChange = { [weak self] state in
            self?.handleStateChange(state)
        }
    }
    
    // MARK: - State Handling
    private func handleStateChange(_ state: FetchState) {
        switch state {
        case .loading:
            showLoading()
            
        case .success(let breeds):
            self.breeds = breeds
            self.filteredBreeds = breeds
            showContent()
            
        case .error(let error):
            showError(error)
        }
    }
    
    private func showLoading() {
        loadingView.isHidden = false
        errorView.isHidden = true
        tableView.isHidden = true
        
        // Extension
        activityIndicator.startLoading()
    }
    
    private func showContent() {
        loadingView.isHidden = true
        errorView.isHidden = true
        tableView.isHidden = false
        
        // Extension
        activityIndicator.stopLoading()
        
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        loadingView.isHidden = true
        errorView.isHidden = false
        tableView.isHidden = true
        
        // Extension UILabel
        errorLabel.setText(
            error.localizedDescription.isEmpty
            ? "Ocurrió un error inesperado"
            : error.localizedDescription
        )
        
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Actions
    @objc private func retryTapped() {
        breedFetcher.fetchBreeds()
    }
    
    @objc private func refreshData() {
        breedFetcher.fetchBreeds()
    }
}
