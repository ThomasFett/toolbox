# Help function
Help() {
    echo "This tool tries to kill the processes belonging to the provided port numbers."\\n

    echo "If the process you want to kill was not created by your current user, you can use sudo together with this script to access all available processes."\\n

    echo "-p  Defines for which ports you want to kill the processes."\\n

    echo "    You can provide a single port: -p 8080"\\n

    echo "    You can provide multiple ports, separated by commas: -p 8080,8090"\\n

    echo "    You can provide a range of ports, separating the first and last port (both of them will also be killed) with a colon: -p 8080:8090"
    echo "    Make sure that the second number is higher than the first one and that you really want to kill all ports in that range."
    echo "    You can aso use a mix of the above, see the example below."\\n

    echo "    Example:"
    echo "    The argument '-p 8080,8081,8090:8093,8200' will try to kill the processes with the following open ports:"
    echo "    8080, 8081, 8090, 8091, 8092, 8093 and 8200"\\n

    echo "-s  Kills the processes with SIGKILL (-9) instead of the default"
    echo "-l  Show a list of processes that have listening ports open (uses the lsof command)"
    echo "-h  Displays this help message. No further code is executed."
    exit 1
}

# Parse optional parameters
while getopts ":lhsp:" opt; do
  case $opt in
    p)
        portArg="$OPTARG"
        ;;
    l)
        lsof -i -sTCP:LISTEN -P
        exit 1
        ;;
    s)
        killOptions="-9 "
        ;;
    h)  # Display Help
        Help
        ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        Help
        ;;
  esac
done

# Check if the ports were specified
if [ -z "$portArg" ]
    then
        echo "ERROR - No ports specified."\\n
        Help
        exit1
fi

# Split port argument by comma
IFS=',' read -a splittedPortsArgs <<< "$portArg"

# Declare array for all ports
declare -a ports

for i in "${splittedPortsArgs[@]}"
do
    if [[ $i == *":"* ]]
      # If a ":" is present all numbers in between the given ports are added as well
      then
        IFS=':' read -a portRange <<< "$i"
        first=${portRange[0]}
        last=${portRange[1]}
        
        # Add first port in range
        ports=( "${ports[@]}" "$first" )

        # Create variable for intermediate ports
        between=$(( $first + 1 ))

        while [[ $between -lt $last ]]
          do
            # Add intermediate port in range
            ports=( "${ports[@]}" "$between" )
            between=$(( $between + 1 ))
        done

        # Add last port in range
        ports=( "${ports[@]}" "$last" )
      # If no ":" is present, just add the value to the port array
      else
        ports=( "${ports[@]}" "$i" )
    fi
done

for i in "${ports[@]}"
do
    echo "Trying to kill port $i..."
    pid=$(lsof -t -i:$i)

    if [ -z "$pid" ]
      then
          echo "Could not find a process for port $i"\\n
      else
          kill $killOptions $pid
          echo "Killed port $i with pid $pid"\\n
    fi
    unset pid
done