myname=$(basename "$0")
delay="$1"

set_trap()
{
    sig=$1
    trap "echo -e '\n$myname received $sig signal';exit 0" $sig
}

trap "echo \"bye from $myname\"" EXIT
set_trap SIGTERM
set_trap SIGINT

#Select sleep mode
if false
then
    echo "Using foreground sleep"
    Sleep()
    {
        sleep $delay
    }
else
    echo "Using background sleep"
    Sleep()
    {
        sleep "$delay" &
        wait $!
    }
fi

#Time to snooze :)
for ((i=0; i<5; i++));
do
    echo "$i: sleeping for $delay"
    Sleep
done

echo "$myname terminated normally"
