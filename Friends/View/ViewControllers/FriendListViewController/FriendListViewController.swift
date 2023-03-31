//
//  FriendListViewController.swift
//  Friends
//
//  Created by Md Saddam Hossain on 30/3/23.
//

import UIKit

class FriendListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var friendList: AllFrinds!
    var isResponsedSuccess = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        FriendViewModel.share.getdataFromAPI { [self] allFrnd in
            friendList = allFrnd
            isResponsedSuccess = true
            DispatchQueue.main.async { [self] in
                listTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      let flag = Reach().isInternetAvailable()
        if flag==false{
            internateAlert()
        }
    }
    func internateAlert(){
        
        let alert = UIAlertController(title: "No Internet", message: "You have no internet", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler:{ (UIAlertAction)in
            self.dismiss(animated: true) { [self] in
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isResponsedSuccess == true{
            return friendList.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.nameLbl.text = friendList.results[indexPath.row].name.title + " " + friendList.results[indexPath.row].name.first + " " + friendList.results[indexPath.row].name.last
        
        cell.countryLbl.text = "\(friendList.results[indexPath.row].location.country)"
        
        FriendViewModel.share.downloadImage(img: friendList.results[indexPath.row].picture.thumbnail, completion: { img in
            cell.personThumbImage.image = img
        })
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc  = UIStoryboard(name: "Friend", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.friendList = friendList
        vc.indx = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
