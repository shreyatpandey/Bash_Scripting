myname=$(basename "$0")
child=sleeploop

set_trap()
{
    sig=$1
    msg="echo -e \"\n$myname received ^C, sending $sig to $child, $pid\""
    trap "$msg; kill -s $sig $pid" SIGINT
}
trap "echo \"bye from $myname\"" EXIT

echo "running $child..."
./$child 5  &
pid=$!

# set_trap SIGINT
set_trap SIGTERM
echo "$child pid = $pid"

wait $pid
echo "$myname finished waiting"


