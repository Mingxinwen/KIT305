//
//  CreateRaffleViewController.swift
//  Raffle
//
//  Created by StarWen on 7/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class CreateRaffleViewController: UIViewController {
    
    @IBOutlet var raffleName: UITextField!
    @IBOutlet var raffleDescription: UITextField!
    @IBOutlet var ticketPrice: UITextField!
    @IBOutlet var rafflePrize: UITextField!
    @IBOutlet var totalTicketNumber: UITextField!
    @IBOutlet var raffleType: UISwitch!
    @IBOutlet var createRaffleBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func creatRaffleBtn(_ sender: UIButton) {
        guard let raffleName = raffleName.text, !raffleName.isEmpty else{
            return
        }
        guard let raffleDescription = raffleDescription.text, !raffleDescription.isEmpty else{
            return
        }
        guard let ticketPrice = Int32(ticketPrice.text!) else{
            return
        }
        guard let rafflePrize = Int32(rafflePrize.text!)else{
            return
        }
        guard let totalTicketNumber = Int32(totalTicketNumber.text!) else{
            return
        }
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        database.insert(raffle:Raffle(name:raffleName, price:ticketPrice, description:raffleDescription, prize:rafflePrize, ticketNumber:totalTicketNumber))
        
    }
    
    @IBAction func cancleBtn(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
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
