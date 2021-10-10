//
//  Bundle.swift
//  TvShowManager
//
//  Created by Awais on 13/09/2021.
//

import Foundation


extension Bundle {

    static var APPLICATION_ID: String? {
        if let key = Bundle.main.object(forInfoDictionaryKey: "APPLICATION_ID") as? String {
            return key
        }

        return nil
    }

    static var CLIENT_KEY: String? {
        if let key = Bundle.main.object(forInfoDictionaryKey: "CLIENT_KEY") as? String {
            return key
        }

        return nil
    }

}
