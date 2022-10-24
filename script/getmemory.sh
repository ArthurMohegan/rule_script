#!/bin/bash


tmpfile="/tmp/procs_mem_$$.txt"
ps --no-headers -eo comm,rss > $tmpfile


#定义函数实现冒泡排序
#使用i控制进行几轮的比较，使用j控制每轮比较的次数
#使用变量len读取数组的个数，根据内存大小进程排序，并且调整对应的进程名称的顺序


proc_order () {
local i j
local len=$1

for ((i=1;i<=$[len-1];i++))
do
        for ((j=1;j<=$[len-i];j++))
        do
                if [ ${mem[j]} -gt ${mem[j+1]} ];then
                        tmp=${mem[j]}
                        mem[j]=${mem[j+1]}
                        mem[j+1]=$tmp
                        tmp=${name[j]}
                        name[j]=${name[j+1]}
                        name[j+1]=${tmp}
                fi
        done
done

#echo "排序后进程序列:"
#echo "-------------------------------"
#echo "${name[@]}"
#echo "排序内存大小:"
#echo "-------------------------------"
#echo "${mem[@]}"

echo -n "" >order.txt
for ((order=$len;order>=0;order--))
do
	echo "${name[order]} ${mem[order]}" >> order.txt
	echo "${name[order]} ${mem[order]}"
done
}



i=1

#使用两个数组分别保存进程名称和进程所占内存大小

while read proc_name proc_mem
do
        name[$i]=$proc_name
        mem[$i]=$proc_mem
        let i++
done < $tmpfile
proc_order ${#name[@]}

