//
//  CityDetailViewController.swift
//  CityLocatorApplication
//
//  Created by Suresh on 02/12/14.
//  Copyright (c) 2014 Neev. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var cityUrlString : String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "City Detail"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var reachabilityStatus = Reachability.reachabilityForInternetConnection().currentReachabilityStatus().value
        if(reachabilityStatus == 0) {
            println("Network unavailable")
            var alerViewController : UIAlertController = UIAlertController(title: "Network Unavailable", message: "Find a source to connect with Network", preferredStyle: UIAlertControllerStyle.Alert)
            var alertAction : UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alerViewController.addAction(alertAction)
            self.presentViewController(alerViewController, animated: true, completion: nil)
            
        }
        else {
            var url : NSURL! = NSURL(string: self.cityUrlString)
            var request : NSURLRequest = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
        
    }
}
