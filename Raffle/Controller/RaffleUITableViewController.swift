//
//  RaffleUITableViewController.swift
//  Raffle
//
//  Created by StarWen on 14/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class RaffleUITableViewController: UITableViewController {
    
    var raffles = [Raffle]()
    @IBOutlet var searchBar: UISearchBar!
    var searchRaffle = [Raffle]()
    var searching = false
    
    
    override func viewDidLoad()
    {
         super.viewDidLoad()
         let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
//        database.insert(raffle:Raffle(name:"RaffleA", price:23, description:"noteA", prize:500, ticketNumber:100))
//        database.insert(raffle:Raffle(name:"RaffleB", price:19, description:"NoteB", prize:600, ticketNumber:200))
//        database.insertTicket(ticket:Ticket(raffleID: 1, customerName:"Adams Smitch"))
//        database.insertTicket(ticket:Ticket(raffleID: 2, customerName:"tony Smitch"))
        raffles = database.selectAllRaffles()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
    return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // add condition searching
        if searching{
            return searchRaffle.count
        } else {
            return raffles.count
        }
       // return raffles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RaffleUITableViewCell", for: indexPath)
        
    // add seaching condition to search raffles
        var currentRaffle = raffles[indexPath.row]
        if searching {
            currentRaffle = searchRaffle[indexPath.row]
        } else{
            currentRaffle = raffles[indexPath.row]
        }
        
        //let raffle = raffles[indexPath.row]
        if let raffleCell = cell as? RaffleUITableViewCell
        {
             raffleCell.nameLable.text = currentRaffle.name
             raffleCell.priceLable.text = String(currentRaffle.price)
        }
        
        return cell
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowRaffleDetailSegue"
            
            //"Showdetailsegue"
            //"ShowRaffleDetailSegue"
    {
    guard let detailViewController = segue.destination as? RaffleDetailViewController else
    {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedRaffleCell = sender as? RaffleUITableViewCell else
    {
                fatalError("Unexpected sender: \( String(describing: sender))")
            }
    guard let indexPath = tableView.indexPath(for: selectedRaffleCell) else
    {
    fatalError("The selected cell is not being displayed by the table") }
    let selectedRaffle = raffles[indexPath.row]
            detailViewController.raffle = selectedRaffle
        }
    }
    //reorder the list only, not the database
        override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let itemTemMove = raffles[sourceIndexPath.item]
            raffles.remove(at: sourceIndexPath.item)
            raffles.insert(itemTemMove, at: destinationIndexPath.item)
        }
     //delete the raffle from array and database
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == .delete){
                raffles.remove(at: indexPath.item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
    //    edit mode button checking  switching text when it being click
        @IBAction func editAction(_ sender: UIBarButtonItem) {
            self.tableView.isEditing = !self.tableView.isEditing
            sender.title = (self.tableView.isEditing) ? "Done": "Edit"
         }
    

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

extension RaffleUITableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText : String) {
        searchRaffle = raffles.filter({(Raffless: Raffle) -> Bool in Raffless.name.lowercased().contains(searchText.lowercased())})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    }
    
    

   
