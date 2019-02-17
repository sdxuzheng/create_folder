#!/bin/bash
#用户头像根地址
dir="/data/web/app.sihemob.com/data/avatar/"
#第二层文件夹数量
dirnum=0
#第一层文件夹数量
dir0num=0
#第二层空文件夹数量
emptydirnum=0
#需要预备的第二层空文件夹数量
needemptydir=40
#需要的第三层文件夹数量，从0开始算
needdir=99
#临时地址记录
tempdir=$dir
cd $dir
for m in $(ls)
do
   if [ -d $m ]
   then
        let dir0num+=1
   fi
done
#第一层文件夹地址
dir1=`expr $dir0num - 1`
if [ $dir1 -lt 10 ]
then
    tempdir=$tempdir"00"$dir1"/"
elif [ $dir1 -ge 10 && $dir1 -lt 100 ]
then
    tempdir=$tempdir"0"$dir1"/"
else
    tempdir=$tempdir$dir1"/"
fi
cd $tempdir
for i in $(ls)
do
   if [ -d $i ]
   then
        let dirnum+=1;
   fi
done
j=`expr $dirnum - 1`
while (( $j<=$dirnum ))
do
   if [ $j -lt 10 ]then
        m="0"$j
   elif [[ $j -ge 10 && $j -lt 100 ]]
   then
        m=$j
   fi
   if [ "`ls -A $tempdir$m/00`" = "" ]
   then
        let emptydirnum+=1
        j=`expr $j - 1`
        continue
   else
        break
   fi
done
if [ $emptydirnum -lt $needemptydir ]
then
   while (( $dirnum$emptydirnum<$dirnum$needemptydir ))
   do
        if [ $dirnum -eq 100 ]
        then
            let dir1+=1
            let dirnum=0
     cd $dir
            if [ $dir1 -lt 10 ]
            then
                mkdir -m 777 $dir"00"$dir1
                tempdir=$dir"00"$dir1"/"
            elif [[ $dir1 -ge 10 && $dir1 -lt 100 ]]
            then
                mkdir -m 777 $dir"0"$dir1
                tempdir=$dir"0"$dir1"/"
            else
                mkdir -m 777 $dir$dir1
                tempdir=$dir$dir1"/"
            fi
        fi
        if [ $dirnum -lt 10 ]
        then
            mkdir -m 777 $tempdir"0"$dirnum
            cd $tempdir"0"$dirnum"/"
        elif [[ $dirnum -ge 10 && $dirnum -lt 100 ]]
        then
            mkdir -m 777 $tempdir$dirnum
            cd $tempdir$dirnum"/"
        fi
 k=0
        while (( $k<=$needdir ))
        do
            if [ $k -lt 10 ]
            then
                mkdir -m 777 "0"$k
            else
                mkdir -m 777 $k
            fi
            let k+=1
        done
        let emptydirnum+=1
        let dirnum=`expr $dirnum + 1`
   done
fi
