//
//  UIViewController+Context.swift
//  MeuBairroApp
//
//  Created by pedohn13@gmail.com on 7/24/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
