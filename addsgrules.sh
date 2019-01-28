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
    echo '  -h  Adds MySQL/Aurora TCP Protocol port 3306'  >&2
    echo '  -i  Adds SSH TCP Protocol port 22'  >&2
    echo '  -j  Adds Custom TCP Protocol Rule ports 1433-1434'  >&2
    echo '  -k  Adds RDP TCP Protocol port 3389'  >&2
    echo '  -l  Adds Custom TCP Rule port 8888'  >&2

    exit 1
}

# Parse the options.
while getopts abcdefghijkl OPTION
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
        k) ADD_RDP='true' ;;
        l) ADD_TCP_8888='true' ;;
        ?) usage ;;
    esac
done

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 2 ]]
then 
    usage
fi

groupID="${2}"

addalltcp() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 0-65535  --cidr 192.199.183.80/30 --group-id ${groupID} 
    aws ec2 authorize-security-group-ingress --protocol tcp --port 0-65535  --cidr 65.158.24.104/30 --group-id ${groupID}
    aws ec2 authorize-security-group-ingress --protocol tcp --port 0-65535  --cidr  204.134.243.168/29 --group-id ${groupID}
}

addalltraffics() {
    aws ec2 authorize-security-group-ingress --protocol all --port all  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol all --port all  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol all --port all  --cidr 204.134.243.168/29 --group-id "${groupID}"
}

addalludp() {
    aws ec2 authorize-security-group-ingress --protocol udp --port 0-65535  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol udp --port 0-65535  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol udp --port 0-65535  --cidr  204.134.243.168/29 --group-id "${groupID}"
}

addcustomtcp() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8080  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8080  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8080  --cidr  204.134.243.168/29 --group-id "${groupID}"
}

addcustomupd() {
    aws ec2 authorize-security-group-ingress --protocol udp --port 1434  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol udp --port 1434  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol udp --port 1434  --cidr 204.134.243.168/29 --group-id "${groupID}"
}

addhttp() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 80  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 80  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 80  --cidr 204.134.243.168/29 --group-id "${groupID}"
}

addhttps() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr  204.134.243.168/29 --group-id "${groupID}"
}

addsql() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3306  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3306  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3306  --cidr  204.134.243.168/29 --group-id "${groupID}"
}

addcustom1433() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 1433-1434  --cidr 192.199.183.80/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 1433-1434  --cidr 65.158.24.104/30 --group-id "${groupID}"
    aws ec2 authorize-security-group-ingress --protocol tcp --port 1433-1434  --cidr  204.134.243.168/29 --group-id "${groupID}"
}

addssh() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 22  --cidr 192.199.183.80/30 --group-id ${groupID} 
    aws ec2 authorize-security-group-ingress --protocol tcp --port 22  --cidr 65.158.24.104/30 --group-id ${groupID}
    aws ec2 authorize-security-group-ingress --protocol tcp --port 22  --cidr  204.134.243.168/29 --group-id ${groupID}
}

addrdp() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3389  --cidr 192.199.183.80/30 --group-id ${groupID} 
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3389  --cidr 65.158.24.104/30 --group-id ${groupID}
    aws ec2 authorize-security-group-ingress --protocol tcp --port 3389  --cidr  204.134.243.168/29 --group-id ${groupID}
}

addtcp8888() {
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8888  --cidr 192.199.183.80/30 --group-id ${groupID} 
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8888  --cidr 65.158.24.104/30 --group-id ${groupID}
    aws ec2 authorize-security-group-ingress --protocol tcp --port 8888  --cidr  204.134.243.168/29 --group-id ${groupID}
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
elif [[ "${ADD_RDP}" = 'true' ]] 
    then
     addrdp
elif [[ "${ADD_TCP_8888}" = 'true' ]] 
    then
    addtcp8888
else 
    usage
fi

#   -a  Adds All TCP Rules ports 0-65535
#   -b  Adds All Traffics ports All
#   -c  Adds All UPD Traffic ports 0-65535
#   -d  Adds Custom TCP Rule port 8080
#   -e  Adds Custom UPD Rule port 1434
#   -f  Adds HTTP TCP Protocol port 80
#   -g  Adds HTTPS TCP Protocol port 443
#   -h  Adds MySQL/Aurora TCP Protocol port 3306
#   -i  Adds SSH TCP Protocol port 22
#   -j  Adds Custom TCP Protocol Rule ports 1433-1434
#   -k  Adds RDP TCP Protocol port 3389'  >&2
#   -l  Adds Custom TCP Rule port 8888'