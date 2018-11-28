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
        let distribution =  TriangolarDistribution.init(a: 2, b: 100, c: 40)
        printDistribution(distribution: distribution!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let activity = activityIndicator {
            activity.isHidden = true
        }
    }
    
    func printDistribution(distribution : ProbabilityDistribution){
        barChartsView.clear()
        barChartsView.clearValues()
        var time : Double = 0
        var dataEntries : [BarChartDataEntry] = []
        while time < 100 {
            let entry = BarChartDataEntry(x : time, y: distribution.probabiltyAtTime(time: time))
            dataEntries.append(entry)
            time += 0.01
        }
        let dataSet = BarChartDataSet.init(values: dataEntries, label: distribution.name)
        let data = BarChartData.init(dataSets: [dataSet])
        barChartsView.data = data
    }
    
    

    @IBAction func startButtonPressed(_ sender: UIButton) {
        numberTextField.resignFirstResponder()
        if let numberTextField = numberTextField, let text = numberTextField.text, let value = Int(text) {
            sender.isEnabled = false
            //graphic code
            if let activity = activityIndicator {
                activity.isHidden = false
                activity.startAnimating()
            }
            let row = pickerView.selectedRow(inComponent: 0)
//            I select the generator of RV according to the user choice
            let randomVariables : RandomVariableGenerator = dictionary[keysArray[row]]!
//            I recall the parallel generator, class used to generate RV in parallel
//            so i will not stop the main thread to perform this task
            parallelGenerator = ParallelDistributionGenerator(randomGenerator: randomVariables)
//            If parallel generator object was correctly generated i use it.
            if let parallel = parallelGenerator {
                parallel.generate(number: value) { (distributions) in
                    //after the completion of the task i manage the graphics
                    //distributions contains the array of distributions generated
                    if let activity = self.activityIndicator {
                        activity.stopAnimating()
                        activity.isHidden = true
                    }
                    sender.isEnabled = true
                    //i create an array to be displayed on the graphic
                    //function is a reference containing the function i am displaying,
                    // in this case average.
                    var array : [(lambda : Int,function :  () -> Double)] = []
                    for i in 0..<distributions.count {
                        array.append((i, distributions[i].average))
                    }
                    
                    //showing on the graph
                    self.barChartsView.clearValues()
                    self.barChartsView.clear()
                    var dataEntry : [BarChartDataEntry] = []
                    for i in array {
                        let entry = BarChartDataEntry(x: Double(i.lambda), y: i.function())
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
