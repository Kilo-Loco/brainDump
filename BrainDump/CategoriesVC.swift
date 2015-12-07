//
//  CategoriesVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/28/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class CategoriesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dumps = [Dump]()
    var selectedDump = Dump()
    
    // MARK: General View Setup
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func fetchAndSetResult() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Dump")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.dumps = results as! [Dump]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.fetchAndSetResult()
        self.tableView.reloadData()
    }
    
    // MARK: Button Functionality
    @IBAction func backBtnPressed(sender: UIButton) {
        performSegueWithIdentifier("CategoriesToVC", sender: nil)
    }
    
    // MARK: TableView Logic
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("DumpCell") as? DumpCell {
            let dump = dumps[indexPath.row]
            cell.configureCell(dump)
            return cell
        } else {
            return DumpCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dumps.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("CategoriesToDump", sender: nil)
        print(self.dumps[indexPath.row].note)
        //self.selectedDump = self.dumps[indexPath.row]
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}
