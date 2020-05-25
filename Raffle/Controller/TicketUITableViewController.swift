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
<<<<<<< Updated upstream

//testing
=======
    var numberOfWinnerFromPreviousView: Int32?
    var numofwinner = 0
<<<<<<< Updated upstream
    var winnerinfor: String?
=======
    var winnerinfor: String = ""
>>>>>>> Stashed changes
    //testing
>>>>>>> Stashed changes
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

    
<<<<<<< Updated upstream
<<<<<<< Updated upstream
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
=======
  
    func drawWinner() -> Ticket?{
            let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))
            numofwinner = numofwinner + 1
            return tickets[randomTicket]
=======
    
    func drawWinner() -> Ticket?{
        //        if(tickets.count > 0 && numofwinner < numberOfWinnerFromPreviousView!){
        let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))
        
        return tickets[randomTicket]
        
        //        else{
        //
        //             let winner = "The raffle already have \(numofwinner) winner \n No more winners!"
        //            var alertController:UIAlertController?
        //            alertController = UIAlertController(title: "Warring",
        //                                                message: winner,
        //                                                preferredStyle: .alert)
        //            let action = UIAlertAction(title: "OK",
        //                                       style: UIAlertAction.Style.default )
        //
        //            alertController?.addAction(action)
        //            self.present(alertController!, animated: true,completion: nil)
        //            return nil
        //        }
        
>>>>>>> Stashed changes
    }
    
    @IBOutlet var DrawingWinnerLabel: UIBarButtonItem!
    
    @IBAction func DrawingWinerButton(_ sender: Any) {
<<<<<<< Updated upstream
       
        if(tickets.count > 0){
            
        while( numofwinner < numberOfWinnerFromPreviousView!){
            let winnerTicket = drawWinner()
            let ticketNumber = winnerTicket?.ticketNumber
            let customerName = winnerTicket?.customerName
            winnerinfor = winnerinfor! + " \n Ticket Number: \(ticketNumber!)\n customer name: \(customerName!)"
=======
        
        if(tickets.count > 0){
            
            if (numofwinner < numberOfWinnerFromPreviousView!) {
                
                while (numofwinner < numberOfWinnerFromPreviousView!) {
                    let winnerTicket = drawWinner()
                    numofwinner = numofwinner + 1
                    let ticketNumber = winnerTicket?.ticketNumber
                    let customerName = winnerTicket?.customerName
                    winnerinfor = winnerinfor + " \n Ticket Number:\(ticketNumber!)\n customer name:\(customerName!)"
                }
                
                let alert = UIAlertController(
                    title: "Winner!",
                    message: winnerinfor,
                    preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(
                    title: "Congratulation!",
                    style: UIAlertAction.Style.cancel,
                    handler: nil ))
                // show the alertself.
                present(alert, animated: true, completion: nil)
                let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
                // database.insert(raffle:Raffle(name:"RaffleA", price:23, description:"noteA", prize:500, ticketNumber:100, currentTicketNumber: 3))
                database.updateRaffle(winner:String(winnerinfor), id:raffleIdFromPreviousView!)
            }else{
                let winner = "The raffle already have \(numofwinner) winner \n No more winners!"
                var alertController:UIAlertController?
                alertController = UIAlertController(title: "Warring",
                                                    message: winner,
                                                    preferredStyle: .alert)
                let action = UIAlertAction(title: "OK",
                                           style: UIAlertAction.Style.default )
                
                alertController?.addAction(action)
                self.present(alertController!, animated: true,completion: nil)
                
                numofwinner = 0
            }
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
>>>>>>> Stashed changes
        }
//        print(winnerinfor!)
        let alert = UIAlertController(
            title: "Winner!",
            message: winnerinfor,
            preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(
            title: "Congratulation!",
            style: UIAlertAction.Style.cancel,
            handler: nil ))
        // show the alertself.
        present(alert, animated: true, completion: nil)
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        database.updateRaffle(winner:String(winnerinfor!), id:raffleIdFromPreviousView!)
        }else {

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
        
        


        
        
>>>>>>> Stashed changes
    }
<<<<<<< Updated upstream
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

=======
    
    
>>>>>>> Stashed changes
}
