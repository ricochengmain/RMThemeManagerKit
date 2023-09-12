//
//  ViewController.swift
//  RMThemeManagerKit
//
//  Created by ricocheng on 09/12/2023.
//  Copyright (c) 2023 ricocheng. All rights reserved.
//

import UIKit
import RMThemeManagerKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var array = Array<RMThemeColorModel>()
        array.append(RMThemeColorModel(
            themeName: "themeA",
            mainColor: .yellow,
            fontColor: .red
        ))
        
        array.append(RMThemeColorModel(
            themeName: "themeB",
            mainColor: .red,
            fontColor: .yellow
        ))
        RMThemeManager.themeColorModels = array
        
        
        let btn = UIButton()
        btn.setTitle("按鈕", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.theme = { currentThemeModel in
            btn.backgroundColor = currentThemeModel.mainColor
        }
        btn.frame.size = CGSize(width: 100, height: 40)
        btn.center = self.view.center
        btn.addTarget(self, action: #selector(event(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc func event(sender: UIButton) {
        RMThemeManager.themeIndex += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RMThemeColorModel {
    private static var associatedKeys: [String: UInt8] = [:]

    private struct AssociatedKey {
        static var mainColor: String = "mainColor"
        static var fontColor: String = "fontColor"
    }
    
    var mainColor: UIColor? {
        set { objc_setAssociatedObject(self, &AssociatedKey.mainColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return (objc_getAssociatedObject(self, &AssociatedKey.mainColor) as! UIColor) }
    }

    var fontColor: UIColor? {
        set { objc_setAssociatedObject(self, &AssociatedKey.fontColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return (objc_getAssociatedObject(self, &AssociatedKey.fontColor) as! UIColor) }
    }

    convenience init(
        themeName: String,
        mainColor: UIColor?,
        fontColor: UIColor?
    ) {
        self.init(themeName: themeName)
        self.mainColor = mainColor
        self.fontColor = fontColor
    }
}


