//
//  DrawingWinnerViewController.swift
//  Raffle
//
//  Created by StarWen on 26/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class DrawingWinnerViewController: UIViewController {
    
    var tickets = [Ticket]()
    var raffleIdFromPreviousView: Int32?
    var numberOfWinnerFromPreviousView: Int32?
    var numofwinner = 0
    var winnerinfor: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
               tickets = database.selectAllTicket(raffleID: raffleIdFromPreviousView!)
               print(numberOfWinnerFromPreviousView!)
        // Do any additional setup after loading the view.
    }
    
    func drawWinner() -> Ticket?{
        let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))
        
        return tickets[randomTicket]
    }
    
    @IBAction func DrawingWinerButton(_ sender: Any) {
    
    if(tickets.count > 0){
        
        while( numofwinner < numberOfWinnerFromPreviousView!){
            let winnerTicket = drawWinner()
            let ticketNumber = winnerTicket?.ticketNumber
            let customerName = winnerTicket?.customerName
            winnerinfor = winnerinfor + " \n Ticket Number: \(ticketNumber!)    Customer Name: \(customerName!)"
            
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
            database.updateRaffle(winner:String(winnerinfor), id:raffleIdFromPreviousView!)
        }
        
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
