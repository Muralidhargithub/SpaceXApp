//
//  Mission.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//


struct Mission: Codable {
    let flightNumber: Int
    let missionName: String
    let rocket: Rocket
    let launchDateUTC: String
    let launchSite: LaunchSite
    let links: MissionLinks
    let details: String?
    let launchSuccess: Bool?

    struct Rocket: Codable {
        let rocketName: String

        private enum CodingKeys: String, CodingKey {
            case rocketName = "rocket_name"
        }
    }

    struct LaunchSite: Codable {
        let siteName: String

        private enum CodingKeys: String, CodingKey {
            case siteName = "site_name"
        }
    }

    struct MissionLinks: Codable {
        let missionPatch: String?
        let articleLink: String?
        let videoLink: String?
        let wikipedia: String?
        let reddit: String?

        private enum CodingKeys: String, CodingKey {
            case missionPatch = "mission_patch"
            case articleLink = "article_link"
            case videoLink = "video_link"
            case wikipedia
            case reddit = "reddit_media"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case rocket
        case launchDateUTC = "launch_date_utc"
        case launchSite = "launch_site"
        case links
        case details
        case launchSuccess = "launch_success"
    }
}

