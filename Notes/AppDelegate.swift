//
//  AppDelegate.swift
//  Notes
//
//  Created by b0ysa on 25/06/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var notesStorage = FileNotebook()
    var photosStorage = Photobook()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLogger() // Uses os_log
        DDLogInfo("App is launching")
        
        setupNotes()
        setupPhotobook()
        return true
    }
    
    private func setupPhotobook() {
        photosStorage.add(Photo(image: UIImage(named: "1")!))
        photosStorage.add(Photo(image: UIImage(named: "2")!))
        photosStorage.add(Photo(image: UIImage(named: "3")!))
        photosStorage.add(Photo(image: UIImage(named: "4")!))
        photosStorage.add(Photo(image: UIImage(named: "5")!))
    }
    private func setupNotes() {
        notesStorage.add(Note(title: "Сходить в магазин", content: "Молоко, хлеб, тортик", importance: .important))
        
        notesStorage.add(
            Note(title: "Вопросы", content: "Что такое мат. ожидание, дисперсия, мода, ковариация, корреляция", importance: .normal)
        )
        
        notesStorage.add(
            Note(title: "тест изменения размера", content: "кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь кусь цмок",color: UIColor.green, importance: .normal)
        )
        
    }

    


}

extension AppDelegate {
    fileprivate func setupLogger() {
        DDLog.add(DDOSLogger.sharedInstance)
        
        // File logger
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger, with: .info)
    }
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}
