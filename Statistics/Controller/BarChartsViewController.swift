//
//  BarChartsViewController.swift
//  Statistics
//
//  Created by Luigi De Marco on 22/11/2018.
//  Copyright © 2018 Luigi De Marco. All rights reserved.
//

import UIKit
import Charts

extension  BarChartView {
    
}

class BarChartsViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    
    var keysArray : [String] {
        return dictionary.keys.map({return $0})
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string : keysArray[row])
    }
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    let dictionary : [String : RandomVariableGenerator] = ["Triangolar D" : TriangolarVariableGenerator(), "Negative Exp Generator" : NegativeExpGen() ]
    
    
    var parallelGenerator : ParallelDistributionGenerator!

    @IBOutlet weak var numberTextField: UITextField!
    
    
    
    @IBOutlet weak var barChartsView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartsView.barData?.barWidth = 0.1
        if let activity = activityIndicator {
            activity.isHidden = true
        }
        pickerView.dataSource = self
        pickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let activity = activityIndicator {
            activity.isHidden = true
        }
    }
    
    

    @IBAction func startButtonPressed(_ sender: UIButton) {
        numberTextField.resignFirstResponder()
        if let numberTextField = numberTextField, let text = numberTextField.text, let value = Int(text) {
            sender.isEnabled = false
            if let activity = activityIndicator {
                activity.isHidden = false
                activity.startAnimating()
            }
            let row = pickerView.selectedRow(inComponent: 0)
            let randomVariables : RandomVariableGenerator = dictionary[keysArray[row]]!
            parallelGenerator = ParallelDistributionGenerator(randomGenerator: randomVariables)
            if let parallel = parallelGenerator {
                parallel.generate(number: value) { (distributions) in
                    if let activity = self.activityIndicator {
                        activity.stopAnimating()
                        activity.isHidden = true
                    }
                    sender.isEnabled = true
                    var array : [(lambda : Int,function :  () -> Double)] = []
                    for i in 0..<distributions.count {
                        array.append((i, distributions[i].average))
                    }
                    
                    self.barChartsView.clearValues()
                    self.barChartsView.clear()
                    var dataEntry : [BarChartDataEntry] = []
                    for i in array {
                        let entry = BarChartDataEntry.init(x: Double(i.lambda), y: i.function())
                        dataEntry.append(entry)
                    }
                    let chartDataSet = BarChartDataSet(values: dataEntry, label: distributions[0].name)
                    let chartData = BarChartData()
                    chartData.addDataSet(chartDataSet)
                    self.barChartsView.data = chartData
                }
            }
            
        }
        else {
            let controller = UIAlertController.init(title: "Error", message: "Insert a correct value", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Dispose", style: .cancel, handler: nil)
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        }
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
