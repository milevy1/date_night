def two_sum(nums, target)
    nums.each do |x|
        nums.each do |y|
            if nums[x] + nums[y] == target
                return [nums[x], nums[y]]
            end
        end
    end
end
