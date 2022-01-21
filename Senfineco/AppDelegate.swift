//
//  AppDelegate.swift
//  Senfineco
//
//  Created by ahmed on 9/2/21.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import goSellSDK
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate, LocalizationManagerDelegate {
    var window: UIWindow?

    func resetApp() {
        guard let window = window  else {return}
        print("local")
        
        if HelperK.checkFristTime() == true{
            
            if HelperK.checkUserToken() == true{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "hom")
        window.rootViewController = vc
        let option : UIView.AnimationOptions = .transitionCrossDissolve
        let duration : TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
                
                }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "login")
                window.rootViewController = vc
                let option : UIView.AnimationOptions = .transitionCrossDissolve
                let duration : TimeInterval = 0.3
                        UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
                }}else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "login")
                window.rootViewController = vc
                let option : UIView.AnimationOptions = .transitionCrossDissolve
                let duration : TimeInterval = 0.3
                        UIView.transition(with: window, duration: duration, options: option, animations: nil, completion: nil)
            }
    
    }
   



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let secretKeyy = SecretKey(sandbox: "sk_test_g0cTKMpYV7RZN4ithjX8omas", production: "sk_live_2uO19PvsN4WcGolnRJFCLBVA")
               GoSellSDK.secretKey = secretKeyy
        LocalizationManager.shared.setAppInnitLanguage()
        LocalizationManager.shared.delegate = self
        IQKeyboardManager.shared.enable = true
        if HelperK.checkFristTime() == true {
            if HelperK.checkUserToken() == true {
                let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hom")
                window?.rootViewController = sb
            }else{
                let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
                window?.rootViewController = sb
            }}else{
                let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "start")
                window?.rootViewController = sb

            }
        return true
    }

    // MARK: UISceneSession Lifecycle

  

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Senfineco")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

