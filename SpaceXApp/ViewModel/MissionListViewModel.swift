//
//  MissionListViewModel.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//


import Foundation

class MissionListViewModel {
    private(set) var missions: [Mission] = []
    var onFetchSuccess: (() -> Void)?
    var onFetchFailure: ((String) -> Void)?

    func fetchMissions() async {
        let url = commonUrl.baseURL
        do {
            let fetchedMissions: [Mission] = try await APIService.shared.fetchData(url: url) // Use `url:`
            DispatchQueue.main.async {
                self.missions = fetchedMissions
                self.onFetchSuccess?()
            }
        } catch let error as NetworkError {
            DispatchQueue.main.async {
                self.onFetchFailure?(error.localizedDescription)
            }
        } catch {
            DispatchQueue.main.async {
                self.onFetchFailure?("An unexpected error occurred: \(error.localizedDescription)")
            }
        }
    }



    func mission(at index: Int) -> Mission {
        return missions[index]
    }
}
