//
//  MissionDetailViewController.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//



import UIKit

class MissionDetailViewController: UIViewController {
    var viewModel: MissionDetailViewModel?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MissionDetailCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mission Info"
        view.backgroundColor = .white
        setupUI()
        bindData()
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func bindData() {
        guard let viewModel = viewModel else { return }

        // Set mission details to the table view
        tableView.reloadData()

        // Load the mission patch image
        if let url = viewModel.missionPatchURL {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Failed to load image: \(error.localizedDescription)")
                        self.imageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
    private func openInBrowser(url: URL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    if !success {
                        print("Failed to open URL: \(url)")
                    }
                }
            } else {
                print("Cannot open URL: \(url)")
            }
        }
}

extension MissionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.missionDetails.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionDetailCell", for: indexPath)

        if let missionDetails = viewModel?.missionDetails {
            let keys = Array(missionDetails.keys)
            let key = keys[indexPath.row]
            let value = missionDetails[key] ?? ""

            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "\(key): \(value)"
            cell.selectionStyle = .none

            if key == "Articles" || key == "Video" || key == "Wikipedia" || key == "Reddit" {
                cell.textLabel?.textColor = .blue
            } else {
                cell.textLabel?.textColor = .black
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let missionDetails = viewModel?.missionDetails else { return }
        let keys = Array(missionDetails.keys)
        let key = keys[indexPath.row]
        let value = missionDetails[key] ?? ""

        if key == "Articles" || key == "Video" || key == "Wikipedia" || key == "Reddit",
           let url = URL(string: value) {
            openInBrowser(url: url)
        }
    }
}



















//import UIKit
//
//class MissionDetailViewController: UIViewController {
//    var viewModel: MissionDetailViewModel?
//
//    private let imageView = UIImageView()
//    private let detailsLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Mission Info"
//        view.backgroundColor = .white
//        setupUI()
//        bindData()
//    }
//
//    private func setupUI() {
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        detailsLabel.numberOfLines = 0
//        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(imageView)
//        view.addSubview(detailsLabel)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200),
//
//            detailsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//        ])
//    }
//
//    private func bindData() {
//        guard let viewModel = viewModel else { return }
//
//        detailsLabel.text = viewModel.missionDetails
//
//        if let url = viewModel.missionPatchURL {
//            Task {
//                do {
//                    let (data, _) = try await URLSession.shared.data(from: url)
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self.imageView.image = image
//                        }
//                    }
//                } catch {
//                    print("Failed to load image: \(error.localizedDescription)")
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(named: "placeholder")
//                    }
//                }
//            }
//        }
//    }
//}











//import UIKit
//
//class MissionDetailViewController: UIViewController {
//    var viewModel: MissionDetailViewModel?
//
//    private let imageView = UIImageView()
//    private let tableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Mission Info"
//        view.backgroundColor = .white
//        setupUI()
//        bindData()
//    }
//
//    private func setupUI() {
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.register(MissionDetailCell.self, forCellReuseIdentifier: "MissionDetailCell")
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44
//
//        view.addSubview(imageView)
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            // ImageView Constraints
//            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200),
//
//            // TableView Constraints
//            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func bindData() {
//        guard let viewModel = viewModel else { return }
//
//        if let url = viewModel.missionPatchURL {
//            Task {
//                do {
//                    let (data, _) = try await URLSession.shared.data(from: url)
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self.imageView.image = image
//                        }
//                    }
//                } catch {
//                    print("Failed to load image: \(error.localizedDescription)")
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(named: "placeholder")
//                    }
//                }
//            }
//        }
//
//        tableView.reloadData()
//    }
//}
//
//// MARK: - UITableViewDataSource
////extension MissionDetailViewController: UITableViewDataSource {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        // Assuming the details are provided as an array of key-value pairs
////        return viewModel?.details.count ?? 0
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissionDetailCell", for: indexPath) as? MissionDetailCell,
////              let detail = viewModel?.details[indexPath.row] else {
////            return UITableViewCell()
////        }
////
////        cell.configure(title: detail.title, value: detail.value)
////        return cell
////    }
////}
//extension MissionDetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel?.missionDetails.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissionDetailCell", for: indexPath) as? MissionDetailCell,
//              let missionDetails = viewModel?.missionDetails else {
//            return UITableViewCell()
//        }
//
//        // Safely extract keys and values
//        let key = Array(missionDetails.keys)[indexPath.row]
//        let value = missionDetails[key] ?? ""
//
//        cell.configure(title: key, value: value)
//        return cell
//    }
//}
