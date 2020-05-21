//
//  SellTicketUIViewController.swift
//  Raffle
//
//  Created by StarWen on 8/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class SellTicketUIViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet var customerName: UITextField!
    @IBOutlet var customerPhone: UITextField!
    @IBOutlet var customerEmail: UITextField!
    @IBOutlet var numberOfTicket: UILabel!
    @IBOutlet var totalCostTextField: UITextField!
    @IBOutlet var totalCostLabel: UILabel!
    
    @IBOutlet var ticketNumberLabel: UILabel!
    
    var nameOfcustomer: String?=nil
    var raffleIdFromTicketView: Int32?
    //total ticket numbere allow to sell for this raffle
    var ticketNumberFromPreviousView: Int32!
    //ticket price from the raffle information page
    var ticketPriceFromPreviousView:Int32?    //current ticket number in the ticket array, how many tickets for this raffle so far
    var currentTicketNumber: Int32 = 0
    //new total ticket number after selling
    var newTicketNumber:Int32 = 0
    //the stepper number of how many ticket you want to sell
    var ticketNumberFromStepper:Int32 = 1
    var arrayTicketNumber: [Int] = []
    //tickets array for checking how many ticket currently
    var ticketPerCustomerPrevious:Int32!
    var arrayToString:String?
    var tickets = [Ticket]()
    var ticket: Ticket?
    
    @IBOutlet var SellButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        tickets = database.selectAllTicket(raffleID: raffleIdFromTicketView!)
        print(tickets.count)
        currentTicketNumber = Int32(tickets.count)
        // Do any additional setup after loading the view.
        self.SellButton.isHidden = false
        self.customerName.text = nameOfcustomer;
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
       
        let combined = "\(String(describing: nameOfcustomer))\n Ticket Number:\n \(numberOfTicket!)"
        let shareviewController = UIActivityViewController(activityItems: [combined], applicationActivities: nil)
        shareviewController.excludedActivityTypes = [UIActivity.ActivityType.postToFacebook]
        shareviewController.popoverPresentationController?.sourceView = self.view
        present(shareviewController,animated: true, completion: nil)
        
    }
    
    @IBAction func ticketStepper(_ sender: UIStepper) {
        ticketNumberFromStepper = Int32(sender.value + 1)
        
        if( 4 > ticketNumberFromStepper) {
            numberOfTicket.text = String(ticketNumberFromStepper)
                   //check total ticket number here
            totalCostLabel.text = String(ticketNumberFromStepper*ticketPriceFromPreviousView!)
            
        }else{
            let combined = " You only by\(4) Tickets"
            let alert = UIAlertController(
                        title: "Warring!",
                        message: combined,
                        preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(
                            title: "Try again!",
                            style: UIAlertAction.Style.cancel,
                            handler: nil ))
            // show the alertself.
            present(alert, animated: true, completion: nil)
             //dismiss(animated: true, completion: nil)
        }
       
    }
    
    @IBAction func sellTicket(_ sender: UIButton) {
        
        newTicketNumber = currentTicketNumber + ticketNumberFromStepper
        if (newTicketNumber <= ticketNumberFromPreviousView!){
            
            let myInt1 = (numberOfTicket.text! as NSString).integerValue

            for u in 1...(myInt1)  {
                let number = currentTicketNumber + Int32(u)
                arrayTicketNumber.append(Int(number))
                   }
            
            arrayToString = (arrayTicketNumber.map{String($0)}).joined(separator: ",")
               ticketNumberLabel.text = arrayToString
            
            guard let customerName = customerName.text, !customerName.isEmpty else{
                
                var alertController:UIAlertController?
                alertController = UIAlertController(title: "Warring",
                                                    message: "Please enter customer name!",preferredStyle: .alert)
                let action = UIAlertAction(title: "OK",
                                           style: UIAlertAction.Style.default )
                
                alertController?.addAction(action)
                self.present(alertController!, animated: true,completion: nil)
                       return
                   }
            guard let customerPhone = Int32(customerPhone.text!) else{
                
                var alertController:UIAlertController?
                alertController = UIAlertController(title: "Warring",
                                                    message: "Please enter customer phone number!",preferredStyle: .alert)
                let action = UIAlertAction(title: "OK",
                                           style: UIAlertAction.Style.default )
                
                alertController?.addAction(action)
                self.present(alertController!, animated: true,completion: nil)
                       return
                   }
            guard let customerEmail = customerEmail.text, !customerEmail.isEmpty else{
                
                var alertController:UIAlertController?
                alertController = UIAlertController(title: "Warring",
                                                    message: "Please enter customer email!",preferredStyle: .alert)
                let action = UIAlertAction(title: "OK",
                                           style: UIAlertAction.Style.default )
                
                alertController?.addAction(action)
                self.present(alertController!, animated: true,completion: nil)
                       return
                   }
            let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase");
            
            for i in arrayTicketNumber {
                database.insertTicket(ticket:Ticket(ticketNumber:Int32(i), raffleID: raffleIdFromTicketView!, customerName:customerName, customerPhone:customerPhone, customerEmail:customerEmail))
            }
            
            let combined = "Ticket Number:\n \(arrayToString!)"
                   
                   let alert = UIAlertController(
                               title: "Ticket Sold!",
                               message: combined,
                               preferredStyle: UIAlertController.Style.alert)
                   // add an action (button)
                   alert.addAction(UIAlertAction(
                                   title: "Good Luck!",
                                   style: UIAlertAction.Style.cancel,
                                   handler: nil ))
                   // show the alertself.
                   present(alert, animated: true, completion: nil)
                   SellButton.isHidden = true
        }else{
        let combined = " Only \(ticketNumberFromPreviousView - currentTicketNumber)Ticket left"
        let alert = UIAlertController(
                        title: "Warring!",
                        message: combined,
                        preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(
                            title: "Try again!",
                            style: UIAlertAction.Style.cancel,
                            handler: nil ))
            // show the alertself.
            present(alert, animated: true, completion: nil)
             //dismiss(animated: true, completion: nil)
        }
        //do something if over sell
       
    }
}
