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

private var mainColorKey: UInt8 = 0
private var fontColorKey: UInt8 = 1

extension RMThemeColorModel {
    private static var associatedKeys: [String: UInt8] = [:]
    
    var mainColor: UIColor? {
        set { objc_setAssociatedObject(self, &mainColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return (objc_getAssociatedObject(self, &mainColorKey) as! UIColor) }
    }

    var fontColor: UIColor? {
        set { objc_setAssociatedObject(self, &fontColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return (objc_getAssociatedObject(self, &fontColorKey) as! UIColor) }
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


