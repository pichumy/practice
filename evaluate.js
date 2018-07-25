// Receive a string of mathematical expressions
// Parse the string and conduct the expression with order of operations
// EXAMPLE: "3+6/4*7^2"
// Currently does not deal well with negative numbers... bleh
// This is kind of bad. Redo with dijkstra's two stack alg... need to figure out how to handle negative numbers and precedence.


const evaluate = (input) => {
  let string = input.repeat(1);
  // first evaluate for exponents
  while(string.indexOf('^') !== -1){
    string = calculate(string, '^');
    console.log(string);
  }
  // Evaluate multiplication and division next.
  while(string.indexOf('*') !== -1 || string.indexOf('/') !== -1){
    let mult = string.indexOf('*');
    let div = string.indexOf('/');
    if(mult > div && div !== -1){
      string = calculate(string, '/');
    }else if(mult !== -1){
      string = calculate(string, '*');
    }else{
      string = calclate(string, '/');
    }
    console.log(string);
  }

  while(string.indexOf('+') !== -1){
    string = calculate(string, '+');
    console.log(string);
  }
  while(string.indexOf('-') !== -1){
    string = calculate(string, '-');
    console.log(string);
  }
  return parseInt(string);
}

const calculate = (string, operation) => {
  let index = string.indexOf(operation);
  let left_value = parse_left(string, index - 1);
  let right_value = parse_right(string, index + 1);
  let start_point = string.indexOf(left_value);
  let end_point = string.indexOf(right_value) + right_value.length - 1;
  let new_string = string.slice(0, start_point);
  let end_string = string.slice(end_point + 1);
  let new_value = null;
  switch (operation){
    case '^':
      console.log('exponent');
      new_value = Math.pow(parseInt(left_value), parseInt(right_value)).toString();
      break;
    case '*':
      console.log('mult');
      new_value = (parseInt(left_value) * parseInt(right_value)).toString();
      break;
    case '/':
      console.log('div');
      new_value = Math.floor(parseInt(left_value) / parseInt(right_value)).toString();
      break;
    case '+':
      console.log('add');
      new_value = (parseInt(left_value) + parseInt(right_value)).toString();
      break;
    case '-':
      console.log('subtract');
      new_value = (parseInt(left_value) - parseInt(right_value)).toString();
      break;
    default: console.log("error, unrecognized operator");
  }
  return new_string + new_value + end_string;
}

const parse_left = (array, index) => {
  if(index === 0){
    return `${array[index]}`;
  }
  if(isNaN(array[index])){
    return '';
  }else{
    return parse_left(array, index - 1) + `${array[index]}`;
  }
}
const parse_right = (array, index) => {
  if(index === array.length - 1){
    return `${array[index]}`;
  }
  if(isNaN(array[index])){
    return '';
  }else{
    return `${array[index]}` + parse_right(array, index + 1);
  }
}

let string = "3+6-8/4*7^2";
console.log(evaluate(string));
