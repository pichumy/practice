# naive solution that doesn't work for certain inputs, like below
def is_shuffle?(main, arr1, arr2)
  temp = ""
  temp1 = ""
  main.chars.each do |char|
    if char == arr1.chars[temp.length]
      temp << char
    elsif char == arr1.chars[temp.length] && char == arr2.chars[temp1.length]
      temp << char
    else
      temp1 << char
    end
  end
  temp == arr1 && temp1 == arr2
end

p is_shuffle?('XXZ', 'XXY', 'XXYXXZ')
