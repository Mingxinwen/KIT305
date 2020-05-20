//
//  TicketUITableTableViewController.swift
//  Raffle
//
//  Created by Vinh Nguyen on 19/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class TicketUITableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tickets = [Ticket]()
    var raffleIdFromPreviousView: Int32?
    var numberOfWinnerFromPreviousView: Int32?
    
    //testing
    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(raffleID: raffleIdFromPreviousView!)
        print(numberOfWinnerFromPreviousView!)
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
    
    
    func drawWinner() -> Ticket?{
        if(tickets.count > 0){
           
            let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))
            
            return tickets[randomTicket]
        }
        else{
            return nil
        }
    }
    @IBAction func DrawingWinerButton(_ sender: Any) {
        let tick = drawWinner()
        let ticketNumber = tick?.ticketNumber
        let customerName = tick?.customerName
        //        print(tick!)
        if(tick != nil){
            
            let winner = " \n Ticket Number:\n \(ticketNumber!)\n customer name:\n \(customerName!)"
            let alert = UIAlertController(
                title: "Winner!",
                message: winner,
                preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(
                title: "Congratulation!",
                style: UIAlertAction.Style.cancel,
                handler: nil ))
            // show the alertself.
            present(alert, animated: true, completion: nil)
            
            // output = responds(ticket: tick!)
            print(tick!)
            //update winner information
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
           // database.insert(raffle:Raffle(name:"RaffleA", price:23, description:"noteA", prize:500, ticketNumber:100, currentTicketNumber: 3))
            database.updateRaffle(winner:String(tick!.customerName), id:raffleIdFromPreviousView!)
           
        }else{
            let alert = UIAlertController(
                title: "Warring!",
                message: "No ticket to drawing!",
                preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(
                title: "Check your raffle!",
                style: UIAlertAction.Style.cancel,
                handler: nil ))
        }
        
    }
    
}
