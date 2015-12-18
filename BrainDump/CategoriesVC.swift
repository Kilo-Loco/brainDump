//
//  CategoriesVC.swift
//  BrainDump
//
//  Created by Kyle Lee on 11/28/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class CategoriesVC: VCCommons, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dumps = [Dump]()
    var deselectedRow: NSIndexPath?
    
    // MARK: General View Setup
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if self.deselectedRow != nil {
            
            let delay = 0.6 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(time, dispatch_get_main_queue(), {
                self.tableView.scrollToRowAtIndexPath(self.deselectedRow!, atScrollPosition: UITableViewScrollPosition.Middle, animated: false)
            })
        }
    }

    func fetchAndSetResult() {
        
        let fetchRequest = NSFetchRequest(entityName: "Dump")
        
        do {
            let results = try CONTEXT.executeFetchRequest(fetchRequest)
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
        
        performSegueWithIdentifier("CategoriesToDump", sender: self)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {

            CONTEXT.deleteObject(self.dumps[indexPath.row] as NSManagedObject)
            
            self.dumps.removeAtIndex(indexPath.row)
            SAVE()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        }
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "CategoriesToDump" {
            let dumpVC = segue.destinationViewController as? DumpVC
            let indexPath = self.tableView.indexPathForSelectedRow
            dumpVC?.selectedDump = self.dumps[indexPath!.row]
            dumpVC?.selectedRow = indexPath
        }
    }
}
