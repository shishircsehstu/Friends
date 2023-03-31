//
//  DetailsViewController.swift
//  Friends
//
//  Created by Md Saddam Hossain on 30/3/23

import UIKit
import MessageUI

class DetailsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var cellPhoneLbl: UILabel!
    
    var friendList: AllFrinds!
    var indx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
    }
    
    func initValue(){
        nameLbl.text = friendList.results[indx].name.title  + " " + friendList.results[indx].name.first + " " +
        friendList.results[indx].name.last
        
        addressLbl.text = friendList.results[indx].location.street.name + "," + "\(friendList.results[indx].location.street.number)" + ", " + friendList.results[indx].location.country
        
        cityLbl.text = friendList.results[indx].location.city + " " +  friendList.results[indx].location.state + " " +  friendList.results[indx].location.country
        
        cellPhoneLbl.text = friendList.results[indx].cell
        
        email.setTitle(friendList.results[indx].email, for: .normal)
        
        FriendViewModel.share.downloadImage(img: friendList.results[indx].picture.large) { [self]  img in
            personImage.image = img
        }
        
    }
    @IBAction func emailAction(_ sender: Any) {
        
        let userMail = friendList.results[indx].email
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([userMail])
            mail.setSubject("Email Subject Here")
            mail.setMessageBody("<p>Write..!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Application is not able to send an email")
            print("Run in real device..")
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
