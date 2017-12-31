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
    var statistic: Statistic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statistic = Statistic()
        //initGraph()
        barChartSetup()
        barChartUpdate()
    }
    
    func barChartUpdate () {
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(50.0))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(50.0))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(50.0))
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Aantal vogels")
        dataSet.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        
        barChart.notifyDataSetChanged()
    }
    
    func barChartSetup(){
        let xAxis:XAxis = barChart.xAxis
        let yAxis:YAxis = barChart.leftAxis
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        yAxis.drawAxisLineEnabled = false
        yAxis.drawGridLinesEnabled = false
        
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
            let dict = snapshot.value as? NSDictionary
            Deserializer.deserializeStatistic(dict: dict!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
