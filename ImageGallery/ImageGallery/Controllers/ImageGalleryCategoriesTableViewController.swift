//
//  ImageGalleryTitleTableViewController.swift
//  ImageGallery
//
//  Created by Plamen on 19.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ImageGalleryCategoriesTableViewController: UITableViewController {

    // MARK: - Table view data source
    let categoriesSections = ["Categories", "Recently Deleted"]
    var categories = ["Nature", "Animals", "Cars"]
    var removedCategories = [String]()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoriesSections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return categories.count
        case 1:
            return removedCategories.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        if  indexPath.section == 0 && categories.count > 0 {
            cell.textLabel?.text = categories[indexPath.row]
        } else if indexPath.section == 1 && removedCategories.count > 0 {
            cell.textLabel?.text = removedCategories[indexPath.row]
        }
        
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
//        if indexPath.section == 1 {
//            return false
//        }
        
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0, editingStyle == .delete {
            // Delete the row from the data source
            removedCategories.append(categories.remove(at: indexPath.row))
            
            tableView.beginUpdates()
            let indexPathToInsert = IndexPath(row: removedCategories.count-1, section: 1)
            tableView.moveRow(at: indexPath, to: indexPathToInsert)
            tableView.endUpdates()
        } else if indexPath.section == 1, editingStyle == .delete {
            removedCategories.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if indexPath.section == 1, editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
            let action = UIContextualAction(style: .normal, title: "Restore") { (action, view, handler) in
                
                self.categories.append(self.removedCategories.remove(at: indexPath.row))
                
                tableView.beginUpdates()
                let indexPathToInsert = IndexPath(row: self.categories.count-1, section: 0)
                tableView.moveRow(at: indexPath, to: indexPathToInsert)
                tableView.endUpdates()
                
                handler(true)
            }
            
            action.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
            let configuration = UISwipeActionsConfiguration(actions: [action])
            
            return configuration
        }
        
        return nil
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
