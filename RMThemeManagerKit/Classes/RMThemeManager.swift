//
//  ThemeManager.swift
//  KeepAccounts
//
//  Created by Rico on 2022/4/6.
//

import Foundation
import UIKit

open class RMThemeColorModel {
    public var themeName: String
    
    public init(themeName: String) {
        self.themeName = themeName
    }
}

open class RMThemeManager {
    
    public static var themeColorModels: Array<RMThemeColorModel> = []
    
    public static var currentThemeModel: RMThemeColorModel {
        return RMThemeManager.themeColorModels[themeIndex]
    }
    
    public static var themeIndex: Int = ((UserDefaults.standard.object(forKey: theme_index) as? Int ?? 0) ) {
        didSet {
            if themeIndex > RMThemeManager.themeColorModels.count - 1 {
                self.themeIndex = 0
            }
            UserDefaults.standard.set(self.themeIndex, forKey: theme_index)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: RMThemeManager.change_theme), object: nil)
        }
    }
    
    public static func themeNamed(_ imageNamed: String) -> String {
        if imageNamed.contains("#theme") {
            let newImageNamed = imageNamed.replacingOccurrences(of: "#theme", with: "_\(themeColorModels[themeIndex].themeName)")
            return newImageNamed
        }
        return imageNamed
    }
    
    internal static let themeInstance: RMThemeManager = {
        let themeInstance = RMThemeManager()
        return themeInstance
    }()
    
    internal static let change_theme: String = "change_theme"
    
    internal static let theme_index: String = "theme_index"
}

private var identifierKey: UInt8 = 0

extension UIView {
    
    public var theme: (_ currentThemeModel: RMThemeColorModel) -> Void {
        set {
            objc_setAssociatedObject(self, &identifierKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.addObserver(self, selector: #selector(change(notification:)), name: NSNotification.Name(rawValue: RMThemeManager.change_theme), object: nil)
            
            DispatchQueue.main.async {
                newValue(RMThemeManager.currentThemeModel)
            }
        }
        
        get {
            return objc_getAssociatedObject(self, &identifierKey) as! (RMThemeColorModel) -> Void
        }
    }
    
    @objc private func change(notification: NSNotification) {
        DispatchQueue.main.async {
            self.theme(RMThemeManager.currentThemeModel)
        }
    }
}
