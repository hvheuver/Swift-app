import Foundation
import Charts

class Statistic{
    var dataEntries: [DataEntry]
    var barChartEntries: [BarChartDataEntry]
    var sumHv = 0, sumZv = 0, sumKv = 0, sumKlv = 0, score = 0
    var owner = ""
    
    init() {
        dataEntries = []
        barChartEntries = []
    }
    
    func appendData(data: DataEntry){
        dataEntries.append(data)
    }
    
    func finalize() {
        // all entries have been added, perform calculations
        for entry in dataEntries {
            sumHv += entry.hoogvogels
            sumZv += entry.zijvogels
            sumKv += entry.kalleVogels
            sumKlv += entry.kleineVogels
        }
        score = (sumHv*4) + (sumZv*3) + (sumKv*2) + sumKlv
        let entryHv = BarChartDataEntry(x: 1.0, y: Double(sumHv))
        let entryZv = BarChartDataEntry(x: 2.0, y: Double(sumZv))
        let entryKv = BarChartDataEntry(x: 3.0, y: Double(sumKv))
        let entryKlv = BarChartDataEntry(x: 4.0, y: Double(sumKlv))
        barChartEntries.append(contentsOf: [entryHv, entryZv, entryKv, entryKlv])
    }
}
