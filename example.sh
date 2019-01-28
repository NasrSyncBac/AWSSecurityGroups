#!/bin/bash
# script update security group to use our new CIDR block ranges for the new building 

if [[ "${UID}" -ne 0 ]]
then 
    echo 'Please, run with sudo or as root.' >&2
   exit 1
fi


# Dispaly the usage and exit
usage() {
    echo "Usage: ${0} ${1} groupID ${2} [abcdefghij]  COMMAND "  >&2
    echo "Add rules to security group" >&2
    echo '  -a  Adds All TCP Rules ports 0-65535'  >&2
    echo '  -b  Adds All Traffics ports All'  >&2
    echo '  -c  Adds All UPD Traffic ports 0-65535'  >&2
    echo '  -d  Adds Custom TCP Rule port 8080'  >&2
    echo '  -e  Adds Custom UPD Rule port 1434'  >&2
    echo '  -f  Adds HTTP TCP Protocol port 80'  >&2
    echo '  -g  Adds HTTPS TCP Protocol port 443'  >&2
    echo '  -h  Adds SQL/Aurora TCP Protocol port 3306'  >&2
    echo '  -i  Adds SSH TCP Protocol port 22'  >&2
    echo '  -j  Adds Custom TCP Protocol Rule ports 1433-1434'  >&2

    exit 1
}

# Parse the options.
while getopts abcdefghij OPTION
do 
    case ${OPTION} in 
        a) ADD_ALL_TCP='true' ;;
        b) ADD_ALL_TRAFFICS='true' ;;
        c) ADD_ALL_UDP='true' ;;
        d) ADD_CUSTOM_TCP='true' ;;
        e) ADD_CUSTOM_UPD='true' ;;
        f) ADD_HTTP='true' ;;
        g) ADD_HTTPS='true' ;;
        h) ADD_SQL='true' ;;
        i) ADD_SSH='true' ;;
        j) ADD_CUSTOM_1433='true' ;;
        ?) usage ;;
    esac
done

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then 
    usage
fi

groupID="${2}"

addalltcp() {
        echo 'Hello addalltcp'  
}

addalltraffics() {
        echo 'Hello addalltraffics '
}

addalludp() {
       echo 'Hello addalludp'

}

addcustomtcp() {
       echo 'Hello'

}

addcustomupd() {
        echo 'Hello'

}

addhttp() {
        echo 'Hello'

}

addhttps() {
       echo 'Hello'

}
addsql() {
    echo 'Hello'

}

addcustom1433() {
       echo 'Hello'

}

addssh() {
    echo 'Hello addssh'
}

# Call a function based on the user selection
if [[ "${ADD_ALL_TCP}" = 'true' ]]
    then
     addalltcp  
elif [[ "${ADD_ALL_TRAFFICS}" = 'true' ]]
    then 
     addalltraffics
elif [[ "${ADD_ALL_UDP}" = 'true' ]]
    then 
     addalludp
elif [[ "${ADD_CUSTOM_TCP}" = 'true' ]]
    then 
     addcustomtcp
elif [[ "${ADD_CUSTOM_UPD}" = 'true' ]]
    then 
     addcustomupd
elif [[ "${ADD_HTTP}" = 'true' ]]
    then 
     addhttp
elif [[ "${ADD_HTTPS}" = 'true' ]]
    then 
     addhttps
elif [[ "${ADD_SQL}" = 'true' ]]
    then 
     addsql
elif [[ "${ADD_SSH}" = 'true' ]]
    then 
     addssh
elif [[ "${ADD_CUSTOM_1433}" = 'true' ]] 
    then
     addcustom1433
else 
    usage
fi