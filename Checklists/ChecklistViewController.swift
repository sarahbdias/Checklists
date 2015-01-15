//
//  ViewController.swift
//  Checklists
//
//  Created by Sarah Dias on 1/7/15.
//  Copyright (c) 2015 SixAgency. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checklist: Checklist!
    
    
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
            let label = cell.viewWithTag(1000) as UILabel
            label.text = item.text
            
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as UILabel
                
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        title = checklist.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return checklist.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem")
        as UITableViewCell
        
    let item = checklist.items[indexPath.row]
        
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        
        let item = checklist.items[indexPath.row]
        item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //1
        checklist.items.removeAtIndex(indexPath.row)
            
        //2
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
          
            
    }
    
    
    
     func addItemViewControllerDidCancel(controller: ItemDetailViewController){
            dismissViewControllerAnimated(true, completion: nil)
            
    }
    
     func addItemViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
               
                let newRowIndex = checklist.items.count
                
                checklist.items.append(item)
                
                let indexPath = NSIndexPath( forRow: newRowIndex, inSection: 0)
                let indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                
                dismissViewControllerAnimated(true, completion: nil)
            
        
                
               
            
    }
    
    func addItemViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
                    if let index = find(checklist.items, item) {
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withChecklistItem: item)
                    
                   
                    
                }
                    }
                    dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                    // 1
                    if segue.identifier == "AddItem" {
                    // 2
                    let navigationController = segue.destinationViewController as UINavigationController
                    // 3
                    let controller = navigationController.topViewController as ItemDetailViewController
                    // 4
                    controller.delegate = self
                    
                } else if segue.identifier == "EditItem" {
                    let navigationController = segue.destinationViewController as UINavigationController
                    let controller = navigationController.topViewController as ItemDetailViewController
                    
                    controller.delegate = self
                    
                    if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                        
                        controller.itemToEdit = checklist.items[indexPath.row]
                  }
    }
    
    }


    
    

}












