//
//  Dump+CoreDataProperties.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/28/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dump {

    // Do not midfiy this code
    @NSManaged var note: String?
    @NSManaged var date: NSDate?
    @NSManaged var category: String?
    @NSManaged var title: String?

}
