//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Sarah Dias on 1/9/15.
//  Copyright (c) 2015 SixAgency. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    
    func addItemViewControllerDidCancel(controller: ItemDetailViewController)
    
    func addItemViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    
    func addItemViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}



class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
        
    let oldText: NSString = textField.text
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        if newText.length > 0 {
        doneBarButton.enabled = true
    } else {
        doneBarButton.enabled = false
        }
        return true
    }
        
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
            if let item = itemToEdit {
            item.text = textField.text
            delegate?.addItemViewController(self, didFinishEditingItem: item)
            
        } else {
            let item = ChecklistItem()
            item.text = textField.text
            item.checked = false
            
            delegate?.addItemViewController(self, didFinishAddingItem: item)
            }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            
            return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
   

}
