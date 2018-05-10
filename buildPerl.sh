#!/bin/bash

## VERSION 1.20180510 ##

#######FUNCTIIONS##########
function makefile {
    perl Makefile.PL
    make
    make manifest
}

function makePod {
    perldoc -uT $PODMOD > README.pod
    perldoc -o Markdown $PODMOD > README.md
    pod2text README.pod > README
}

#########GLOBAL VARIABLES###############
FLAG="$1"

PODMOD="$(grep "VERSION_FROM" ../Makefile.PL | cut -d "'" -f 2-2)"

#####TESTING
if [ "$FLAG" == 'test' ]
then
    cd ..
    makefile
    makePod
    prove -l -v t/*.t
fi

#####AUTHOR TESTS
if [ "$FLAG" == 'auth' ]
then
    cd ..
    makefile
    makePod
    prove -l t/*.t
    prove -l xt/*.t
fi

#####BUILD DISTRIBUTION
if [ "$FLAG" == 'dist' ]
then
    cd ..
    makefile
    makePod
    make distdir && make disttest && make distcheck && make dist && make tardist
fi


#####STATUS AND EXIT
echo "-----------------------------------------------"
echo "FLAG = ${FLAG}"
echo "PODMOD = ${PODMOD}"
echo "-----------------------------------------------"

exit