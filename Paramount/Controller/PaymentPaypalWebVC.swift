//
//  PaymentPaypalWebVC.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 05/06/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit
import SVProgressHUD

class PaymentPaypalWebVC: UIViewController,UIWebViewDelegate,UITextFieldDelegate {
    @IBOutlet var paypalWebview: UIWebView!
    
    var check = String()
    var cardNumber = String()
    var expireDate = String()
    var amountStr = String()
    var currencyStr = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        check = "none"
        var str = String()
        str = "AYqh0mzbmclzlOONL2nrNsx1Yu5h_wue7w6cejJnAkQSf5qClaTBKm8Ta_6UjZJOGYAsgglQAKQnwnW-"
        
        //AR9xduDMnhqE20X2pMax2Ywu-ZK7bG00hmiLJcOpT0NuFNeEhRugL-_4BPLK-PqIzKp47FL-hIzLRGKH
        
        
        // Manjit Client ID //AfhVxBUKOnf1E1DeT4o7-CQA0rfUco2NLLG0OAYXGdSRuf8gjbxzH7P77bTevnzY_1I60N6MXYYeLQqO
        
        // Ashish sir Client ID //AYqh0mzbmclzlOONL2nrNsx1Yu5h_wue7w6cejJnAkQSf5qClaTBKm8Ta_6UjZJOGYAsgglQAKQnwnW-
        
        let service = ServerHandler()
        let dicto = NSMutableDictionary()
        dicto .setValue(amountStr, forKey: "amount")
        dicto .setValue(currencyStr, forKey: "currency")
      //  dicto .setValue(str, forKey: "client_id")

//        print(dicto)
//        service .serviceRequest(withInfo: dicto as! [AnyHashable : Any], serviceType: ServiceTypePostAmount, params: nil) { (response, error) in
//            print(response as Any)
//        }
        
        var urlString = NSString()
        urlString = String(format: "http://203.92.41.131/paypal.php?amount=%@&currency=%@", amountStr,currencyStr) as NSString
        print(urlString)
        let url = NSURL (string: urlString as String);
        let request = NSURLRequest(url: url! as URL);
        paypalWebview.loadRequest(request as URLRequest);
        paypalWebview.keyboardDisplayRequiresUserAction = true
 
        // keyboard hide and show
        let notifier = NotificationCenter.default
        notifier.addObserver(self,selector: #selector(keyboardWillShowNotification(_:)), name: UIWindow.keyboardWillShowNotification,object: nil)
        notifier.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)),name: UIWindow.keyboardWillHideNotification,object: nil)
        
      // for observe pushnotification value
        NotificationCenter.default.addObserver(self, selector: #selector(self.getNotificationDataFormPushNotify(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    @objc func getNotificationDataFormPushNotify(_ notification: NSNotification)
    {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary?
        {
        print(dict)
        }
    }
    @objc
    func keyboardWillShowNotification(_ notification: NSNotification) {
    
        self.getCardData()
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        print("HIDE")
    }
  
    func getCardData()  {
        let service = ServerHandler()
        service .serviceRequest(withInfo: nil, serviceType: ServiceTypeGetCardDetails, params: nil) { (response, error) in
            var dict = NSDictionary()
            dict = response as! NSDictionary
            print(dict)

            //   let name = "12345678901234"
            var nameStr = String()
            nameStr = dict .value(forKey: "card_number") as! String// card_number
            
            if nameStr == ""
            {
                print("DATA NOT FOUND")
            }
            else
            {
                let name = nameStr
              //  let name = "4335 8778 6426 0400"
                var js = "var textfield = document.getElementById('credit-card-number');\n"  //cc
                js += "textfield.value = '" + name + "';"
                self.paypalWebview.stringByEvaluatingJavaScript(from: js)
            }
            
            var expireStr = String()
            expireStr = dict .value(forKey: "expiry_date") as! String
            if expireStr == ""
            {
                print("DATA NOT FOUND")
            }
            else
            {
                let expireDate = expireStr
                var js1 = "var textfield = document.getElementById('expiration');\n"  //expiry_value
                js1 += "textfield.value = '" + expireDate + "';"
                self.paypalWebview.stringByEvaluatingJavaScript(from: js1)
            }
        }
    }
    
    @objc
    func textFieldTextChanged(_ notification: NSNotification) {
        print("TEXT FIELD")

        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
    }
    func textFieldDidChange(_ textField: Notification) {
        //your code
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //let script = "document.documentElement.style.webkitUserSelect='none'"
//    if let returnedString = webView.stringByEvaluatingJavaScriptFromString(script) {
//        println("the result is \(returnedString)")
 //   }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        let script = "document.documentElement.style.webkitUserSelect='none'"
        if let returnedString = paypalWebview.stringByEvaluatingJavaScript(from: script) {
            print("the result is \(returnedString)")
        }
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if request.url?.scheme == "none" {
            print("NONE")
            if request.url?.host == "home" {
                // do something
            }
        }
                return true
    }

       @IBAction func backBTN(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
