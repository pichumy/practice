// merge intervals if unsorted
const mergeIntervals = (array) => {
  let intervals = []
  array.forEach(interval => {
    // ensure that intervals are in order
    if(interval[0] > interval[1])
      [interval[0], interval[1]] = [interval[1], interval[0]]
    // base case when intervals are empty
    let merged = false;
    for(let i = 0; i < intervals.length; i++){
      // case for starting after existing interval, but starting before or when that interval ends
      if(interval[0] >= intervals[i][0] && interval[0] <= intervals[i][1]){
        // if this interval ends later, add it on to the existing interval
        if(interval[1] > intervals[i][1]){
          merged = true;
          intervals[i][1] = interval[1]
        }
      }else if (interval[0] < intervals[i][0] && interval[0] < intervals[i][1]){
        // case for starting earlier than existing interval, and ending before existing ends
        intervals[i][0] = interval[0];
        if(interval[1] > intervals[i][1]){
          intervals[i][1] = interval[1]
        }
        merged = true;
      }
    }
    if (!merged)
      intervals.push(interval)
  })
  return intervals;
}
console.log("1")
let input = [[3, 6], [1, 5], [8, 10], [15, 18]]
console.log(input)
let output = mergeIntervals(input)
console.log(output)
let new_input = [[1, 4], [4, 5]];
console.log("2")
console.log(new_input)
let output2 = mergeIntervals(new_input);
console.log(output2);
console.log("3")
let input3 = [[1, 2], [2, 6], [5, 15]]
console.log(input3)
let output3 = mergeIntervals(input3)
console.log(output3)
