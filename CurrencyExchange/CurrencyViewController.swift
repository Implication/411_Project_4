//
//  CurrencyViewController.swift
//  CurrencyExchange
//
//  Created by Trajon Felton on 5/5/17.
//  Copyright © 2017 Trajon Felton. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var c = Currency.list.shared.c
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var foreignTableView: UITableView!
    var currency = [String]()
    var currencyDict = [String:String]()
    var selectedHomeCell : String = ""
    var selectedForeignCell : String = ""
    
    @IBOutlet weak var CurrencyTextField: UITextField!
    @IBOutlet weak var ConvertLabel: UILabel!
    override func viewDidLoad() {
        for i in c {
            if i.check == true{
                currency.append(i.name)
            }
        }
        super.viewDidLoad()
        currencyDict = Demo()
        print(self.currencyDict.count)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.reloadData()
        foreignTableView.delegate = self
        foreignTableView.dataSource = self
        foreignTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector (handleSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleSwipe(_ sender:UIGestureRecognizer){
        self.performSegue(withIdentifier: "favorites",sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.myTableView {
            count = currency.count
        }
        
        if tableView == self.foreignTableView {
            count = currency.count
        }
        
        return count!
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if tableView == self.myTableView{
        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell!.textLabel?.text = currency[indexPath.row]
        }
        
        if tableView == self.foreignTableView{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell1")
            cell!.textLabel!.text = currency[indexPath.row]
        }
        
            
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        if tableView == self.myTableView{
            selectedHomeCell = (cell?.textLabel!.text)!
            print(selectedHomeCell)
        }
        if tableView == self.foreignTableView {
            selectedForeignCell = (cell?.textLabel!.text)!
            print(selectedForeignCell)
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        currency.removeAll()
        for i in c {
            if i.check == true{
                currency.append(i.name)
                i.check = false;
            }
        }
        print("Refreshed")
        self.myTableView.reloadData()
        self.foreignTableView.reloadData()
    }
    
    @IBAction func addNewCurrencies(_ sender: Any) {
        currency.removeAll()
        for i in c {
            i.check = false
        }
        self.myTableView.reloadData()
        self.foreignTableView.reloadData()
    }
    func Demo() -> Dictionary<String,String>
    {
        let myYQL = YQLS()
        let queryString = "select * from yahoo.finance.xchange where pair in" +
        "(\"USDEUR\",\"USDINR\", \"USDGBP\", \"USDAUD\", \"USDCAD\", " +
        "\"EURUSD\", \"EURGBP\", \"EURINR\", \"EURAUD\", \"EURCAD\", " +
        "\"GBPUSD\", \"GBPEUR\", \"GBPINR\", \"GBPAUD\", \"GBPCAD\", " +
        "\"INRUSD\", \"INRGBP\", \"INREUR\", \"INRAUD\", \"INRCAD\", " +
        "\"AUDUSD\", \"AUDGBP\", \"AUDINR\", \"AUDEUR\", \"AUDCAD\", " +
        "\"CADUSD\", \"CADGBP\", \"CADINR\", \"CADAUD\", \"CADEUR\" )"
        var currencyDictionary = [String:String]()
        myYQL.query(queryString) { jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
            let resultsDict = queryDict["results"] as! [String: Any]
            let rateArray = resultsDict["rate"] as! [Any]
            for i in 0..<rateArray.count {
                let rateDict = rateArray[i] as! [String: Any]
                let name = rateDict["id"] as! String
                let rate = rateDict["Rate"] as! String
                currencyDictionary.updateValue(rate, forKey: name)
                print(currencyDictionary.count)
            }
        }
        sleep (2)
        return currencyDictionary
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let amount : Float = Float(CurrencyTextField.text!)!
        var homeSymbol : String = ""
        var foreignSymbol : String = ""
        for i in c {
            if selectedHomeCell == i.name {
                homeSymbol = i.symbol
            }
            if selectedForeignCell == i.name {
                foreignSymbol  = i.symbol
            }
        }
        if selectedHomeCell == selectedForeignCell {
            ConvertLabel.text = homeSymbol + String(format: "%.2f", amount) + " is " +  foreignSymbol + String(format: "%.2f", amount)
        }
        else {
            var homeISO : String = ""
            var foreignISO : String = ""
            for i in c {
                if selectedForeignCell == i.name {
                    foreignISO = i.isoCode
                }
                if selectedHomeCell == i.name {
                    homeISO = i.isoCode
                }
            }
        
            let rate: Float = Float(currencyDict[homeISO + foreignISO]!)!
            let convertAmount: Float = amount * rate
            ConvertLabel.text = homeSymbol + String(format: "%.2f", amount) + " is " +  foreignSymbol + String(format: "%.2f", convertAmount)
        }
    }
}
