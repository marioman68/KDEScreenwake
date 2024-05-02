#!/bin/bash

if test -f /lib/systemd/system-sleep/wake.sh; then
    rm /lib/systemd/system-sleep/wake.sh
fi


cat > "/lib/systemd/system-sleep/wake.sh" << "EOL"
mon=($(kscreen-doctor -o | grep Output | sed 's/^.*: //' | awk '{print $2}'))
EOL
read -p "Primary Monitor: " name

#printf $name

#mon2=($(kscreen-doctor -o | grep Output | sed 's/^.*: //' | awk '{print $2}'))

sed -i -e '1i#!/bin/bash' /lib/systemd/system-sleep/wake.sh
sed -i -e '2isleep 5' /lib/systemd/system-sleep/wake.sh
echo 'kscreen-doctor output."${mon[0]}".enable' >> /lib/systemd/system-sleep/wake.sh
echo 'kscreen-doctor output."${mon[1]}".enable' >> /lib/systemd/system-sleep/wake.sh
echo 'kscreen-doctor output."${mon[2]}".enable' >> /lib/systemd/system-sleep/wake.sh

case $name in

    1)
        
        echo 'kscreen-doctor output."${mon[0]}".primary' >> /lib/systemd/system-sleep/wake.sh        
        ;;
    2)
        echo 'kscreen-doctor output."${mon[1]}".primary' >> /lib/systemd/system-sleep/wake.sh
        ;;
    3)
        echo 'kscreen-doctor output."${mon[2]}".primary' >> /lib/systemd/system-sleep/wake.sh
        ;;

esac
chmod +x "/lib/systemd/system-sleep/wake.sh"


