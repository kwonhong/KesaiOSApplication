//
//  editViewController.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 6. 29..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit

class editViewController: UIViewController {
    
    var test1 = NSString()
    var test2 = NSString()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleText: UITextField!
    
    @IBAction func dismissListner(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getTitle(title: NSString) {
        test1 = title
    }
    
    func getSubTitle(subTitle: NSString) {
        test2 = subTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = test1 as String
        subTitleText.text = test2 as String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
