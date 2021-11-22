#!/bin/bash


start=`date +%s`

replace_dirs(){
    echo -n "Enter the directory for bin(Press Ctrl+D if you dont want to change it): "
    read temp
    if [ -d $temp ]; then
        bin=$temp
    else
        mkdir -p $temp
        bin=$temp
    fi
    echo -n "Enter the directory for inc(Press Ctrl+D if you dont want to change it): "
    read temp
        if [ -d $temp ]; then
        inc=$temp
    else
        mkdir -p $temp
        inc=$temp
    fi
    echo -n "Enter the directory for lib(Press Ctrl+D if you dont want to change it): "
    read temp
        if [ -d $temp ]; then
        lib=$temp
    else
        mkdir -p $temp
        lib=$temp
    fi
    echo -n "Enter the directory for src(Press Ctrl+D if you dont want to change it): "
    read temp
        if [ -d $temp ]; then
        src=$temp
    else
        mkdir -p $temp
        src=$temp
    fi
}
log_date=`date +%d.%m.%Y`
log="logs/${log_date}.log"
if [ -e $log ]; then
    echo -e File is good.
else
    touch $log
fi
processed_dirs=0
moved_exes=0
moved_libs=0
moved_srcs=0
moved_includes=0
bin="bin"
inc="inc"
lib="lib"
src="src"
echo -n "Enter the directories you want to work with(press Ctrl+D when finished): "
while read line
do
    dirs=("${dirs[@]}" $line)
done

if [ ${#dirs[@]} -eq 0 ]; then

    echo "The array is empty, no directories given"

else
    echo >> $log
    while true; do
        read -p "Do you wish to use different directories this program? " yn
         case $yn in
            [Yy]* ) replace_dirs; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    for dir in ${dirs[@]}; do
        if [ -d $dir ]; then
            let processed_dirs++
            for entry in "$dir"/*; do
                case $entry in
                    *.lib)
                        mv -t $lib $entry
                        let moved_libs++
                        echo `date +%H:%M:%S`": mv -t " ${lib} ${entry} >> $log
                        ;;
                    *.exe)
                        mv -t $bin $entry
                        let moved_exes++
                        echo `date +%H:%M:%S`": mv -t " ${bin} ${entry} >> $log
                        ;;
                    *.c | *.cc | *.cpp | *.cxx)
                        mv -t $src $entry
                        let moved_srcs++
                        echo `date +%H:%M:%S`": mv -t " ${src} ${entry} >> $log
                        ;;
                    *.h | *.hxx)
                        mv -t $inc $entry
                        let moved_includes++
                        echo `date +%H:%M:%S`": mv -t " ${inc} ${entry} >> $log
                        ;;
                    *)
                        echo -e "Not a good file extension"'\n'
                        ;;
                esac
            done
        else
            echo "The  directory does no exist"
            continue
        fi
    done
fi
echo -e There were ${processed_dirs} processed dirs.
echo -e There were ${moved_exes} moved executables.
echo -e There were ${moved_libs} moved libraries.
echo -e There were ${moved_includes} moved includes.
echo -e There were ${moved_srcs}  moved sources.
end=`date +%s`
runtime=$((end-start))
echo -e It took ${runtime} seconds to finish the script.