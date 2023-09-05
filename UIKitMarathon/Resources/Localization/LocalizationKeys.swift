//
//  LocalizationKeys.swift
//  UIKitMarathon
//
//  Created by Sergei Semko on 9/5/23.
//

import Foundation

enum LocalizationKeys {
    private static let _showVideo: String = "showVideo"
    private static let _showSolution: String = "showSolution"
    private static let _showYouTubeSolution: String = "showYouTube"
}

extension LocalizationKeys {
    static var showVideo: String {
        return Self._showVideo.localized
    }
    
    static var showSolution: String {
        return Self._showSolution.localized
    }
    
    static var showYouTubeSolution: String {
        return Self._showYouTubeSolution.localized
    }
}

extension String {
    var localized: Self {
        return NSLocalizedString(self, comment: "")
    }
}
