//
//  MissionCell.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//


import UIKit

class MissionCell: UITableViewCell {
    private let missionImageView = UIImageView()
    private let missionNameLabel = UILabel()
    private let rocketNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        missionImageView.contentMode = .scaleAspectFit
        missionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        missionNameLabel.font = .boldSystemFont(ofSize: 16)
        missionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rocketNameLabel.font = .systemFont(ofSize: 14)
        rocketNameLabel.textColor = .gray
        rocketNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(missionImageView)
        contentView.addSubview(missionNameLabel)
        contentView.addSubview(rocketNameLabel)
        
        NSLayoutConstraint.activate([
            missionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            missionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            missionImageView.widthAnchor.constraint(equalToConstant: 50),
            missionImageView.heightAnchor.constraint(equalToConstant: 50),
            
            missionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            missionNameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 12),
            missionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            rocketNameLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 4),
            rocketNameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 12),
            rocketNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            rocketNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with mission: Mission) {
        missionNameLabel.text = mission.missionName
        rocketNameLabel.text = mission.rocket.rocketName
        
        if let urlString = mission.links.missionPatch, let url = URL(string: urlString) {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.missionImageView.image = image
                        }
                    }
                } catch {
                    print("Failed to load image: \(error.localizedDescription)")
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
