#!/bin/bash

## VERSION 1.20180406 ##

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
    make test TEST_VERBOSE=1
fi

#####AUTHOR TESTS
if [ "$FLAG" == 'auth' ]
then
    cd ..
    makefile
    makePod
    make test TEST_VERBOSE=1
    make test TEST_FILE='xt\*.t' TEST_VERBOSE=1
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