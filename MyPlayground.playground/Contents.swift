import UIKit

var dataChart = [99, 0, 7, 5, 45]
var dataChart2 = [76, 8, 12, 0, 66]

let maxData = dataChart.max() ?? 0 > dataChart2.max() ?? 0 ? dataChart.max() : dataChart2.max()

print("cek maxdata: \(maxData)")
