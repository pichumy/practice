# Merge M sorted lists of different lengths
def mergeM(lists)
  results = []
  until lists.empty?
    smallest_idx = 0
    lists.each_with_index do |_, idx|
      smallest_idx = idx if lists[idx][0] < lists[smallest_idx][0]
    end
    results << lists[smallest_idx].shift
    lists.delete_at(smallest_idx) if lists[smallest_idx].length == 0
  end
  results
end
p "hey"
input = [[10, 20, 30, 40], [15, 25, 35], [27, 29, 37, 48, 93], [32, 33]]

print mergeM(input)

# N * M time complexity
# M comparisons per number
# [1], [2], [3] => 3 numbers, 3 lists
# 1 compares vs 2 compares vs 3, remove 1 , M operations
# [2], [3] , M -1 operations
# [3], M - 2 operations RIP
