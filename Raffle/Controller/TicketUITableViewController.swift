//
//  TicketUITableTableViewController.swift
//  Raffle
//
//  Created by Vinh Nguyen on 19/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class TicketUITableViewController: UITableViewController {
    
    var tickets = [Ticket]()
    var raffleIdFromPreviousView: Int32?

//testing
    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(raffleID: raffleIdFromPreviousView!)
        print(tickets.count)
//        tickets = database.selectAllTicket(raffleID: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickets.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TicketUITableViewCell", for: indexPath)
    
        let ticket = tickets[indexPath.row]
        if let ticketleCell = cell as? TicketUITableViewCell
        {
             ticketleCell.CustomerNameLabel.text = ticket.customerName
            ticketleCell.TicketNumberLabel.text = String(ticket.ticketNumber)

        }
        
        return cell
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowTicketDetailSegue"
            
            //"Showdetailsegue"
            //"ShowRaffleDetailSegue"
    {
    guard let detailViewController = segue.destination as? TicketDetailViewController else
    {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedTicketCell = sender as? TicketUITableViewCell else
    {
                fatalError("Unexpected sender: \( String(describing: sender))")
            }
    guard let indexPath = tableView.indexPath(for: selectedTicketCell) else
    {
    fatalError("The selected cell is not being displayed by the table") }
    let selectedTicket = tickets[indexPath.row]
            detailViewController.ticket = selectedTicket
        }
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
