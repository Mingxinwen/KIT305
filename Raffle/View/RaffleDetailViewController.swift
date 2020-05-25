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

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    @IBOutlet var raffleId: UILabel!
    @IBOutlet var rafflePrize: UILabel!
    @IBOutlet var totalNumberOfTicket: UILabel!
<<<<<<< Updated upstream
=======
    @IBOutlet var numberOfWinnerLabel: UILabel!
<<<<<<< Updated upstream
=======
    @IBOutlet var winnerInforlabel: UITextView!
>>>>>>> Stashed changes
    @IBOutlet var winnerLabel: UILabel!
    
    
>>>>>>> Stashed changes
    
    var raffleID: Int32!
    var ticketNumber: Int32!
    var currentTicketNumber: Int32!
    var ticketPrice: Int32!
<<<<<<< Updated upstream
=======
    var numberOfWinner: Int32!
    var pastRaffleCheck: Bool!
>>>>>>> Stashed changes
    

    
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
<<<<<<< Updated upstream
         
=======
            numberOfWinnerLabel.text = String(displayRaffle.numberOfWinner)
            numberOfWinner = displayRaffle.numberOfWinner
<<<<<<< Updated upstream
            winnerLabel.text = displayRaffle.winnerOfRaffle!
            print(displayRaffle.winnerOfRaffle!)
>>>>>>> Stashed changes
    } }
=======
            winnerInforlabel.text = displayRaffle.winnerOfRaffle
            pastRaffleCheck = displayRaffle.winnerOfRaffle!.isEmpty
    }
        if (pastRaffleCheck == true) {
            winnerInforlabel.isHidden = true
            winnerLabel.isHidden = true
        }
    }
>>>>>>> Stashed changes
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        if segue.identifier == "ticketUITableView"
        {
            let nextScreen = segue.destination as! TicketUITableViewController
            nextScreen.raffleIdFromPreviousView = raffleID
        }
        if segue.identifier == "ticketSellView"
        {
            let nextScreen = segue.destination as! SellTicketUIViewController
            nextScreen.raffleIdFromTicketView = raffleID
            nextScreen.ticketNumberFromPreviousView = ticketNumber
            nextScreen.ticketPriceFromPreviousView = ticketPrice
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
