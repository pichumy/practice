const binary_isolation = (array) => {
  while (array.length > 1){
    let middle = Math.floor(array.length / 2);
    if(array[middle - 1] === array[middle]){
      if(middle % 2 == 0)
        array = array.slice(0, middle)
      else
        array = array.slice(middle + 1)
    }else{
      if(middle % 2 == 0)
        array = array.slice(middle)
      else
        array = array.slice(0, middle)
    }
  }
  return array
}
array = [1, 1, 3, 3, 5, 5, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 13, 13, 17, 17, 18];
// 17 inputs

binary_isolation(array)
