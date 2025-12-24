import Foundation

// MARK: - Breed Fetcher State
enum FetchState {
    case loading
    case success([Breed])
    case error(Error)
}

// MARK: - Breed Fetcher
class BreedFetcher {

    var stateDidChange: ((FetchState) -> Void)?

    private(set) var state: FetchState = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.stateDidChange?(self.state)
            }
        }
    }

    func fetchBreeds() {
        state = .loading

        CatService.shared.fetchBreeds { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let breeds):
                self.state = .success(breeds)

            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    // MARK: - Mock para testing y previews
    static func mockSuccess() -> BreedFetcher {
        let fetcher = BreedFetcher()
        fetcher.state = .success([
            Breed(
                id: "abys",
                name: "Abyssinian",
                temperament: "Active, Energetic, Independent",
                origin: "Egypt",
                description: "The Abyssinian is easy to care for, and a joy to have in your home.",
                lifeSpan: "14 - 15",
                weight: Weight(imperial: "7 - 10", metric: "3 - 5"),
                image: nil
            ),
            Breed(
                id: "aege",
                name: "Aegean",
                temperament: "Affectionate, Social, Intelligent",
                origin: "Greece",
                description: "Native to the Greek islands known as the Cyclades in the Aegean Sea.",
                lifeSpan: "9 - 12",
                weight: Weight(imperial: "7 - 10", metric: "3 - 5"),
                image: nil
            )
        ])
        return fetcher
    }
}
