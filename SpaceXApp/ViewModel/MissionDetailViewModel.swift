//
//  MissionDetailViewModel.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.
//

import Foundation


class MissionDetailViewModel {
    private(set) var mission: Mission?

    func setMission(_ mission: Mission) {
        self.mission = mission
    }

    var missionDetails: [String: String] {
        guard let mission = mission else { return ["Error": "No details available"] }

        return [
            "Mission Name": mission.missionName,
            "Rocket Name": mission.rocket.rocketName,
            "Launch Site": mission.launchSite.siteName,
            "Launch Date": mission.launchDateUTC,
            "Success": mission.launchSuccess == true ? "Yes" : "No",
            "Articles": mission.links.articleLink ?? "No",
            "Video" : mission.links.videoLink ?? "N/A",
            "Wikipedia": mission.links.wikipedia ?? "N/A",
            "Reddit": mission.links.reddit ?? "N/A",
            "Details": mission.details ?? "N/A"
        ]
    }
    var missionPatchURL: URL? {
            guard let urlString = mission?.links.missionPatch else { return nil }
            return URL(string: urlString)
        }
}















//import Foundation
//
//class MissionDetailViewModel {
//    private(set) var mission: Mission?
//
//    func setMission(_ mission: Mission) {
//        self.mission = mission
//    }
//
//    var missionDetails: [String: String] {
//        guard let mission = mission else { return ["Error": "No details available"] }
//
//        return [
//            "Mission Name": mission.missionName,
//            "Rocket Name": mission.rocket.rocketName,
//            "Launch Site": mission.launchSite.siteName,
//            "Launch Date": mission.launchDateUTC,
//            "Success": mission.launchSuccess == true ? "Yes" : "No",
//            "Articles": mission.links.articleLink ?? "No",
//            "Video" : mission.links.videoLink ?? "N/A",
//            "Wikipedia": mission.links.wikipedia ?? "N/A",
//            "Reddit": mission.links.reddit ?? "N/A",
//            "Details": mission.details ?? "N/A"
//        ]
//    }
//
//    var missionPatchURL: URL? {
//        guard let urlString = mission?.links.missionPatch else { return nil }
//        return URL(string: urlString)
//    }
//}
