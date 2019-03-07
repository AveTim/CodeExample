//
//  String+Localization.swift
//  TestLoginApp
//
//  Created by Tim on 3/7/19.
//  Copyright © 2019 Heads and Hands. All rights reserved.
//

import Foundation

extension String {
    
    public func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    public func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    public func pluralizedFormat(_ arguments: CVarArg...) -> String {
        return withVaList(arguments) {
            NSString(format: localized(), locale: NSLocale.current, arguments: $0) as String
        }
    }
        
    public func localized(using tableName: String?) -> String {
        return localized(using: tableName, in: .main)
    }
    
    public func localized(in bundle: Bundle?) -> String {
        return localized(using: nil, in: bundle)
    }
    
    public func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value:"", comment: "")
    }
}
