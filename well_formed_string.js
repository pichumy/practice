const KEYS = {
  '{': '}',
  '[': ']',
  '(': ')'
}

const wellFormedString = (string) => {
  let idx = 0
  let stack = []
  let open = Object.keys(KEYS);
  let close = Object.values(KEYS);
  while (idx < string.length){
    if (open.includes(string[idx])){
      stack.push(string[idx]);
    }
    if (close.includes(string[idx])){
      let val = stack.pop();
      if (!(KEYS[val] === string[idx])){
        return false
      }
    }
    idx += 1
  }
  if (stack.length === 0)
    return true
  else
    return false
}

wellFormedString("{]")
