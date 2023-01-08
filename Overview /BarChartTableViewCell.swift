//
//  BarChartTableViewCell.swift
//  SpendIt301
//
//  Created by Fatema Marhoon on 28/12/2022.
//

import UIKit
import Charts
class BarChartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BarChart: BarChartView!
    //fake data
   // let income = [100,200,300]
   // let expenses = [20,10,30,5,4,400]
    var inc: Double = 0.0
    var exp : Double = 0.0
    var total : Double = 0.0
    var transactions : [Transaction] = Transaction.loadTransactions()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeChart()
        BarChart.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
      
    }
    func customizeChart() {
        //set up chart settings
        BarChart.chartDescription.enabled = true
        BarChart.xAxis.drawGridLinesEnabled = false
        BarChart.xAxis.drawLabelsEnabled = false
        BarChart.xAxis.drawAxisLineEnabled = false
        BarChart.rightAxis.enabled = false
        BarChart.leftAxis.enabled = false
        BarChart.drawBordersEnabled = false
        BarChart.legend.form = .none
        

        //data entries for the bar chart
        var dataEntries = [BarChartDataEntry]()
        var dataEntries1 = [BarChartDataEntry]()
        
    //testtt
        total = 0
        exp = 0
        inc = 0
        for transaction in transactions {
            if transaction.category.type == "Expense" {
                exp += transaction.amount
                
            }else {
                inc += transaction.amount
            }
        }
        
        
        
        
        
//        for i in 0..<self.xaxisValue.count {
        let i = 0
           //let sumOfIncome = inc.reduce(0,+)
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(inc))
            dataEntries.append(dataEntry)
       // let sumOfExpenses = expenses.reduce(0,+)
            let dataEntry1 = BarChartDataEntry(x: Double(i), y: Double(exp))
            dataEntries1.append(dataEntry1)
//        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Income")
          let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Expenses")
        
        //color of the data sets(bars)
        chartDataSet.colors = [UIColor(red: 224/255, green: 223/255, blue: 119/255, alpha: 1)]
        chartDataSet1.colors =   [UIColor(red: 27/255, green: 87/255, blue: 95/255, alpha: 1)]
        //sizes / spaces
          let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        let chartData = BarChartData(dataSets: dataSets)
        BarChart.data = chartData
        let groupSpace = 0.4
         let barSpace = 0.02
        let barWidth = 0.05

         chartData.barWidth = barWidth
         chartData.setDrawValues(true)
        BarChart.xAxis.axisMinimum = 0.0
//        BarChart.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.xaxisValue.count)

         chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
//        BarChart.xAxis.granularity = BarChart.xAxis.axisMaximum / Double(self.xaxisValue.count)
        
        BarChart.drawValueAboveBarEnabled = true
       BarChart.keepPositionOnRotation = true
        BarChart.clipValuesToContentEnabled = true

        //this code rotate the barss
//       BarChart.getAxis(.left).inverted = true

        BarChart.notifyDataSetChanged()
//        BarChart.setVisibleXRangeMaximum(4)
//        BarChart.setVisibleXRangeMinimum(4)
        BarChart.animate(yAxisDuration: 1.0, easingOption: .linear)
        

        
        
    }

}
