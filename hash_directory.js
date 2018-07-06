const hashdir = (obj) => {

  let arr = []
  for(let key in obj){
    if (obj[key] === true){
      arr.push(key)
    }
    else{
      let sub_arr = hashdir(obj[key])
      sub_arr.forEach(file => {
        arr.push(`${key}/${file}`)
      })
    }
  }
  return arr
}

let input = {
  'a': {
    'b': {
      'c': {
        'd': {
          'e': true
        },
        'f': true
      }
    }
  }
}

let output = hashdir(input)
console.log(output);
