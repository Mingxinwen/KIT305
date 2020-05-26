//
//  RaffleDetailViewController.swift
//  Raffle
//
//  Created by StarWen on 14/4/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class RaffleDetailViewController: UIViewController {
    var raffle : Raffle?
    var tickets = [Ticket]()
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    @IBOutlet var raffleId: UILabel!
    @IBOutlet var rafflePrize: UILabel!
    @IBOutlet var totalNumberOfTicket: UILabel!
    @IBOutlet var numberOfWinnerLabel: UILabel!
    @IBOutlet var winnerDetailLabel: UITextView!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var navigationbar: UINavigationItem!
    
    
    var raffleID: Int32!
    var ticketNumber: Int32!
    var currentTicketNumber: Int32!
    var ticketPrice: Int32!
    var numberOfWinner: Int32!
    var numofwinner = 0
    var winnerinfor: String = ""
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let displayRaffle = raffle
        {
            nameLabel.text = displayRaffle.name
            priceLable.text = String(displayRaffle.price)
            descriptionLable.text = displayRaffle.description
            raffleId.text = String(displayRaffle.ID)
            rafflePrize.text = String(displayRaffle.prize)
            totalNumberOfTicket.text = String(displayRaffle.ticketNumber)
            raffleID = displayRaffle.ID
            ticketNumber = displayRaffle.ticketNumber
            currentTicketNumber = displayRaffle.currentTicketNumber
            ticketPrice = displayRaffle.price
            numberOfWinnerLabel.text = String(displayRaffle.numberOfWinner)
            numberOfWinner = displayRaffle.numberOfWinner
            winnerDetailLabel.text = displayRaffle.winnerOfRaffle
//            if (displayRaffle.winnerOfRaffle!.isEmpty) {
             if (displayRaffle.winnerOfRaffle!.isEmpty) {
                winnerDetailLabel.isHidden = true
                winnerLabel.isHidden = true
            }
            
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(raffleID: raffleID)
        print(tickets)
        }
        
        }
    
    func drawWinner() -> Ticket?{
        let randomTicket = Int(arc4random_uniform(UInt32(tickets.count)))
        
        return tickets[randomTicket]
    }
        
    @IBAction func DrawingWinner(_ sender: UIButton) {
        if(tickets.count == 0){
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Warring",
                                                message: "There is not ticket to draw winners!",preferredStyle: .alert)
            let action = UIAlertAction(title: "Create your ticket first!",
                                       style: UIAlertAction.Style.default )
            
            alertController?.addAction(action)
            self.present(alertController!, animated: true,completion: nil)
            return
        }else if(tickets.count < numberOfWinner){
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Warring",
                                                message: "You don't have enough ticket to draw winners!",preferredStyle: .alert)
            let action = UIAlertAction(title: "Create more tickets first!",
                                       style: UIAlertAction.Style.default )
            
            alertController?.addAction(action)
            self.present(alertController!, animated: true,completion: nil)
            return
        }
        
        if (numofwinner < numberOfWinner) {
        
        while (numofwinner < numberOfWinner) {
            let winnerTicket = drawWinner()
            numofwinner = numofwinner + 1
            let ticketNumber = winnerTicket?.ticketNumber
            let customerName = winnerTicket?.customerName
            winnerinfor = winnerinfor + " \n Ticket Number:\(ticketNumber!)\n customer name:\(customerName!)"
        }
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        database.updateRaffle(winner:String(winnerinfor), id:raffleID)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        if segue.identifier == "ticketUITableView"
        {
            let nextScreen = segue.destination as! TicketUITableViewController
            nextScreen.raffleIdFromPreviousView = raffleID
            nextScreen.numberOfWinnerFromPreviousView = numberOfWinner
            
            
        }
        if segue.identifier == "ticketSellView"
        {
            let nextScreen = segue.destination as! SellTicketUIViewController
            nextScreen.raffleIdFromTicketView = raffleID
            nextScreen.ticketNumberFromPreviousView = ticketNumber
            nextScreen.ticketPriceFromPreviousView = ticketPrice
        }
        
        if segue.identifier == "drawingWinnerView"
        {
            let nextScreen = segue.destination as! WinnerViewController
            nextScreen.winnersDetailFromPreviousPage = winnerinfor
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
