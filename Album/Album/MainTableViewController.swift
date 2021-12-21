//
//  MainTableViewController.swift
//  Album
//
//  Created by bb on 2021/12/21.
//

import UIKit

class MainTableViewController: UITableViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func ChooseWay(_ sender: Any) {
        let PhotoViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //_ = PhotoViewController.view
        let alertController = UIAlertController(title: "选择方式", message: nil, preferredStyle: .actionSheet)
        let Action1 = UIAlertAction(title: "Choose from Album", style: .default, handler:{ (alert: UIAlertAction!) -> Void in
            self.navigationController?.pushViewController(PhotoViewController, animated: true)
            PhotoViewController.choosePhoto()
                })
        let Action2 = UIAlertAction(title: "Take a photo", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.navigationController?.pushViewController(PhotoViewController, animated: true)
            PhotoViewController.takePicture()
                })
        let Action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
                    print("取消")
                })
        alertController.addAction(Action1)
        alertController.addAction(Action2)
        alertController.addAction(Action3)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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

