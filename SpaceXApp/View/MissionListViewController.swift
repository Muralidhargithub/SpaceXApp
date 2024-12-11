//
//  MissionListViewController.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//


import UIKit

class MissionListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = MissionListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Missions"
        setupTableView()
        bindViewModel()
        Task {
            await viewModel.fetchMissions()
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MissionCell.self, forCellReuseIdentifier: "MissionCell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onFetchSuccess = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onFetchFailure = { errorMessage in
            print(errorMessage)
        }
    }
}

extension MissionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.missions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell", for: indexPath) as? MissionCell else {
            return UITableViewCell()
        }

        let mission = viewModel.mission(at: indexPath.row)
        cell.configure(with: mission)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mission = viewModel.mission(at: indexPath.row)
        let detailVC = MissionDetailViewController()
        let detailViewModel = MissionDetailViewModel()
        detailViewModel.setMission(mission)
        detailVC.viewModel = detailViewModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
