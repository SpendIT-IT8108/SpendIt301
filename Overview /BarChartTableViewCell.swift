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

    var inc: Double = 0.0
    var exp : Double = 0.0
    var balance : Double = 0.0
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
        BarChart.xAxis.axisMinimum = 0.0
        BarChart.drawValueAboveBarEnabled = true
       BarChart.keepPositionOnRotation = true
        BarChart.clipValuesToContentEnabled = true
        BarChart.notifyDataSetChanged()
        BarChart.animate(yAxisDuration: 1.0, easingOption: .linear)
        //position the title in center
        let legend = BarChart.legend
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.textWidthMax = 2
       // legend.formToTextSpace = 1
        //legend.xEntrySpace = 5
//        legend.xEntrySpace = 0
//        legend.yEntrySpace = 0
//        legend.yOffset = 10
//        legend.xOffset = 10

        //data entries for the bar chart
        var dataEntries = [BarChartDataEntry]()
        var dataEntries1 = [BarChartDataEntry]()
        var dataEntries2 = [BarChartDataEntry]()
        
    //calculate required data
        balance = 0
        exp = 0
        inc = 0
        for transaction in transactions {
            if transaction.category.type == "Expense" {
                exp += transaction.amount
                
            }else {
                inc += transaction.amount
            }
            balance = inc - exp
        }
        
    
        let i = 0
      //set char data entry
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(inc))
            dataEntries.append(dataEntry)
     
            let dataEntry1 = BarChartDataEntry(x: Double(i), y: Double(exp))
            dataEntries1.append(dataEntry1)
        
           let dataEntry2 = BarChartDataEntry(x: Double(i), y: Double(balance))
           dataEntries2.append(dataEntry2)
        //set chart data set
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Income    ")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Expenses    ")
        let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Balance")
        //color of the data sets(bars)
        chartDataSet.colors = [UIColor(red: 224/255, green: 223/255, blue: 119/255, alpha: 1)]
        chartDataSet1.colors =   [UIColor(red: 27/255, green: 87/255, blue: 95/255, alpha: 1)]
        chartDataSet2.colors =   [UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)]
      
        //set chart data set
          let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
        let chartData = BarChartData(dataSets: dataSets)
        //asign it to the chart
        BarChart.data = chartData
        //set sizes - dpaxes
        let groupSpace = 0.37
         let barSpace = 0.008
        let barWidth = 0.040

         chartData.barWidth = barWidth
         chartData.setDrawValues(true)
        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        

    }

}
