//
//  MainViewController.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var context: NSManagedObjectContext!
    
    @IBOutlet weak var shopsButton: UIButton!
    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activity.isHidden = true
        ExecuteOneInteractorImplementation().execute {
            self.messageLabel.text = "Connexion failed"
            self.shopsButton.alpha = 0
            self.activitiesButton.alpha = 0
            activity.isHidden = false
            activity.startAnimating()
            
            let queue = OperationQueue()
            queue.addOperation {
                //Testear si hay conexión
                var network = isConnectedToNetwork()
                while !network {
                    network = isConnectedToNetwork()
                }
                OperationQueue.main.addOperation {
                    self.messageLabel.text = "Cargando datos de internet"
                    self.initializeData()
                }
            }
        }
    }
    
    func initializeData() {
        let urlShops = "https://madrid-shops.com/json_new/getShops.php"
        let urlActivities = "https://madrid-shops.com/json_new/getActivities.php"
        
        //Descargo las tiendas
        let downloadShops: DownloadAllInteractor = DownloadAllInteractorNSURLSessionImplementation()
        downloadShops.execute(context: context, urlString: urlShops, type: .ShopCD) {
            //Descargo las actividades
            let downloasActivities: DownloadAllInteractor = DownloadAllInteractorNSURLSessionImplementation()
            downloasActivities.execute(context: self.context, urlString: urlActivities, type: .ActivityCD, onSuccess: {
                //Arranco la App (todo descargado y cacheado)
                SetExecutedOnceInteractorImplementation().execute()
                UIView.animate(withDuration: 2.0, animations: {
                    self.shopsButton.alpha = 1.0
                    self.activitiesButton.alpha = 1.0
                    self.messageLabel.text = ""
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                })
            })
        }
    }
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let vc1 = segue.destination as! ShopsViewController
            vc1.context = self.context
        }
        if segue.identifier == "ShowActivitiesSegue" {
            let vc2 = segue.destination as! ActivitiesViewController
            vc2.context = self.context
        }
    }

}
