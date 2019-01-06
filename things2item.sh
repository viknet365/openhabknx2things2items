#! /bin/bash
regexbridge="\s*Bridge\s+knx:ip:(\S+).*"
regexthing="\s*Thing\s+device\s+(\S+).*"
regextype="\s*Type\s+(\S+)\s+:\s+(\S+)\s+(.*)\s+\[.*\]"
while read line
do
 if [[ $line =~ $regexbridge ]]
 then
  bridge="${BASH_REMATCH[1]}"
#  echo "bridge: $bridge"
fi
 if [[ $line =~ $regexthing ]]
 then
  thing="${BASH_REMATCH[1]}"
#  echo "thing: $thing"
fi
 if [[ $line =~ $regextype ]]
 then
  type="${BASH_REMATCH[1]}"
  name="${BASH_REMATCH[2]}"
  desc="${BASH_REMATCH[3]}"
  echo "${type^}  $name $desc { channel=\"knx:device:$bridge:$thing:$name\"   }"
fi


done < "${1:-/dev/stdin}"
