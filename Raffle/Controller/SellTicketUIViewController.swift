//
//  SellTicketUIViewController.swift
//  Raffle
//
//  Created by StarWen on 8/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class SellTicketUIViewController: UIViewController {
    @IBOutlet var customerName: UITextField!
    @IBOutlet var customerPhone: UITextField!
    @IBOutlet var customerEmail: UITextField!
    @IBOutlet var numberOfTicket: UILabel!
    var raffleIdFromTicketView: Int32?
    //total ticket numbere allow to sell for this raffle
    var ticketNumberFromPreviousView: Int32?
    //ticket price from the raffle information page
    var ticketPriceFromPreviousView:Int32?
    //current ticket number in the ticket array, how many tickets for this raffle so far
    var currentTicketNumber: Int32 = 0
    //new total ticket number after selling
    var newTicketNumber:Int32 = 0
    //the stepper number of how many ticket you want to sell
    var ticketNumberFromStepper:Int32 = 1
    //tickets array for checking how many ticket currently
    var tickets = [Ticket]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(raffleID: raffleIdFromTicketView!)
        print(tickets.count)
        currentTicketNumber = Int32(tickets.count)
        // Do any additional setup after loading the view.
    }
    @IBAction func ticketStepper(_ sender: UIStepper) {
        ticketNumberFromStepper = Int32(sender.value + 1)
        numberOfTicket.text = String(ticketNumberFromStepper)
        //check total ticket number here
    }
    
    @IBAction func sellTicket(_ sender: UIButton) {
        guard let customerName = customerName.text, !customerName.isEmpty else{
            return
        }
        guard let customerPhone = Int32(customerPhone.text!) else{
            return
        }
        guard let customerEmail = customerEmail.text, !customerEmail.isEmpty else{
            return
        }
        
        newTicketNumber = currentTicketNumber + ticketNumberFromStepper
        if (newTicketNumber <= ticketNumberFromPreviousView!){
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
            database.insertTicket(ticket:Ticket(ticketNumber:123, raffleID: raffleIdFromTicketView!, customerName:customerName, customerPhone:customerPhone, customerEmail:customerEmail))
        }
        //do something if over sell
        dismiss(animated: true, completion: nil)
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
