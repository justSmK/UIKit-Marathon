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
}

extension LocalizationKeys {
    static var showVideo: String {
        return Self._showVideo.localized
    }
    
    static var showSolution: String {
        return Self._showSolution.localized
    }
}

extension String {
    var localized: Self {
        return NSLocalizedString(self, comment: "")
    }
}
