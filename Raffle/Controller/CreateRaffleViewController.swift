//
//  CreateRaffleViewController.swift
//  Raffle
//
//  Created by StarWen on 7/5/20.
//  Copyright © 2020 StarWen. All rights reserved.
//

import UIKit

class CreateRaffleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var raffleName: UITextField!
    @IBOutlet var raffleDescription: UITextField!
    @IBOutlet var ticketPrice: UITextField!
    @IBOutlet var rafflePrize: UITextField!
    @IBOutlet var totalTicketNumber: UITextField!
    @IBOutlet var raffleType: UISwitch!
    @IBOutlet var createRaffleBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var ticketPerCustomer: UITextField!
    var customerby: Int32? = nil
   
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
        
        _ = Int32(ticketPerCustomer.text!)
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
        database.insert(raffle:Raffle(name:raffleName, price:ticketPrice, description:raffleDescription, prize:rafflePrize, ticketNumber:totalTicketNumber, currentTicketNumber:0))
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?){

                  if segue.identifier == "GetTicketPerCustomerSegue"
                  {
                      let nextScreen = segue.destination as! SellTicketUIViewController
                   nextScreen.ticketPerCustomerPrevious = customerby
                  }

              }
    
    @IBAction func galleryButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                   print("Gallery availble")
                   let imagePicker:UIImagePickerController = UIImagePickerController()
                              imagePicker.delegate = self
                              imagePicker.sourceType = .photoLibrary;
                              imagePicker.allowsEditing = false
                              
                              self.present(imagePicker, animated: true, completion: nil)
               }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                     dismiss(animated: true, completion: nil)
                 }
   
}


