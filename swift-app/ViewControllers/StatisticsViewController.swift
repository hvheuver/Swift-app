import UIKit

import Firebase
import Charts
import FirebaseDatabase
/**
 Used this tutorial to get to know the Charts pod.
 https://github.com/annalizhaz/ChartsForSwiftBasic
 Tried to get an as nice looking chart as possible, lack of documentation.
*/
class StatisticsViewController: UIViewController {
    @IBOutlet weak var barChart: BarChartView!
    var statistic: Statistic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartSetup()
        if statistic != nil {
            // Viewcontroller is slower
            barChartUpdate()
        }
    }
    
    func barChartUpdate () {
        let dataSet = BarChartDataSet(values: statistic!.barChartEntries, label: "Aantal vogels")
        dataSet.colors = ChartColorTemplates.pastel()
        dataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 24.0)!
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.notifyDataSetChanged()
    }
    
    func barChartSetup(){
        let xAxis:XAxis = barChart.xAxis
        let yAxis:YAxis = barChart.leftAxis
        let font = UIFont(name: "HelveticaNeue-Light", size: 24.0)!
        // gridlines
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        yAxis.drawAxisLineEnabled = false
        // set larger fonts
        xAxis.labelFont = font
        yAxis.labelFont = font
        // disable right yAxis
        barChart.rightAxis.enabled = false
        // disabled the tiny legend
        barChart.legend.enabled = false
        // add labels
        barChart.chartDescription?.enabled = false
        let birds = ["", "HV", "ZV", "KV", "KLV"]
        xAxis.valueFormatter = IndexAxisValueFormatter(values: birds)
        xAxis.granularity = 1
    }
    
    @IBAction func unwindFromAddData(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "didAddData" else {
            fatalError("Unknown segue")
        }
        //reload statistics
        initGraph(ref: Database.database().reference())
    }
    
    func initGraph(ref: DatabaseReference){
        // get remote data
        let userid = Auth.auth().currentUser?.uid
        ref.child("statistics").child(userid!).observe(DataEventType.value, with: { (snapshot) in
            guard let dict = snapshot.value as? NSDictionary else{
                return
            }
            self.statistic = Deserializer.deserializeStatistic(dict: dict)
            self.statistic!.finalize()
            if self.barChart != nil {
                // async is slow than viewDidLoad
                self.barChartUpdate()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}
