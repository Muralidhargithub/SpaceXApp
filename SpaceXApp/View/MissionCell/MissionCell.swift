//
//  MissionCell.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//


import UIKit

class MissionCell: UITableViewCell {
    // MARK: - UI Components
    private let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let missionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let launchDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(missionImageView)
        contentView.addSubview(missionNameLabel)
        contentView.addSubview(rocketNameLabel)
        contentView.addSubview(launchDetailsLabel)

        NSLayoutConstraint.activate([
            missionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            missionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionImageView.widthAnchor.constraint(equalToConstant: 80),
            missionImageView.heightAnchor.constraint(equalToConstant: 80),

            missionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            missionNameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 12),
            missionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            rocketNameLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 4),
            rocketNameLabel.leadingAnchor.constraint(equalTo: missionNameLabel.leadingAnchor),
            rocketNameLabel.trailingAnchor.constraint(equalTo: missionNameLabel.trailingAnchor),

            launchDetailsLabel.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor, constant: 4),
            launchDetailsLabel.leadingAnchor.constraint(equalTo: missionNameLabel.leadingAnchor),
            launchDetailsLabel.trailingAnchor.constraint(equalTo: missionNameLabel.trailingAnchor),
            launchDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        missionImageView.image = nil
    }

    // MARK: - Configure Cell
    func configure(with mission: Mission) {
        missionNameLabel.text = mission.missionName
        rocketNameLabel.text = mission.rocket.rocketName

        // Display "Launched at..." details
        let launchSiteName = mission.launchSite.siteName
        let launchDate = mission.launchDateUTC.prefix(10) // Extract the date part
        launchDetailsLabel.text = "Launched at \(launchSiteName) on \(launchDate)"

        if let urlString = mission.links.missionPatch, let url = URL(string: urlString) {
            Task {
                if let (data, _) = try? await URLSession.shared.data(from: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.missionImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.missionImageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        } else {
            missionImageView.image = UIImage(named: "placeholder")
        }
    }
}
