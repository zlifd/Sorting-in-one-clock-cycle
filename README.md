# Sorting-in-one-clock-cycle
A sorting engine in ascending or descending order for m n-bits words

Given m n-bits words, we may sort them in ascending order by setting `sortType=0` or in descending order with `sortType=1`. User may define the depth (how many words) in the parameter `m` and the width (bit lenght of each word) in the parameter `n` in the `sorting.v`. A testbench sorting in ascending order with 15 8-bits words is given in `sorting_tb.v`. And the behaviour simulation is shown below:



![](/behav_sim.png)
