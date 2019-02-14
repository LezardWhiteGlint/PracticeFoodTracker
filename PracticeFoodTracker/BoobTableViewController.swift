//
//  BoobTableViewController.swift
//  PracticeBoobsTracker
//
//  Created by Lezardvaleth on 2019/2/12.
//  Copyright © 2019 Lezardvaleth. All rights reserved.
//

import UIKit
import os.log

class BoobTableViewController: UITableViewController {
    //MARK: Properties
    var boobs = [Boob]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        // Load any saved meals, otherwise load sample data.
        if let savedBoobs = loadBoobs() {
            boobs += savedBoobs
        } else {
            loadSamplePics()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return boobs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BoobTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BoobTableViewCell else {
            fatalError("The dequeued cell is not an instance of BoobTableViewCell.")
        }
        let boob = boobs[indexPath.row]
        cell.nameLabel.text = boob.name
        cell.photoImageView.image = boob.photo
        cell.ratingControl.rating = boob.rating
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            boobs.remove(at: indexPath.row)
            saveBoobs()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new boob", log: OSLog.default, type:.debug)
        case "ShowDetail":
            guard let boobDetailViewController = segue.destination as? BoobViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedBoobCell = sender as? BoobTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for:selectedBoobCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedBoob = boobs[indexPath.row]
            boobDetailViewController.boob = selectedBoob
        default:
            fatalError("Unexpected Segue Identifier;\(segue.identifier)")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToBoobList(sender:UIStoryboardSegue) {

        if let sourceViewController = sender.source as? BoobViewController, let boob = sourceViewController.boob {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Updating the existing boob
                boobs[selectedIndexPath.row] = boob
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //Add new boob
                let newIndexPath = IndexPath(row: boobs.count, section: 0)
                boobs.append(boob)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveBoobs()
        }
    }
    
    
    //MARK: Private methods
    private func loadSamplePics() {
        let photo1 = UIImage(named: "game1")
        let photo2 = UIImage(named: "game2")
        let photo3 = UIImage(named: "game3")
        
        guard let boob1 = Boob(name: "test1", photo: photo1, rating: 3) else {
            fatalError("Unable to instantiate boob")
        }
        guard let boob2 = Boob(name: "test2", photo: photo2, rating: 4) else {
            fatalError("Unable to instantiate boob")
        }
        guard let boob3 = Boob(name: "test4", photo: photo3, rating: 5) else {
            fatalError("Unable to instantiate boob")
        }
        boobs += [boob1,boob2,boob3]
    }
    
    private func saveBoobs() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(boobs, toFile: Boob.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Boobs successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Fail to save boobs...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadBoobs() -> [Boob]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Boob.ArchiveURL.path) as? [Boob]
    }

}
