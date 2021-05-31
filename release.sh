#!/bin/bash

set -e

if (( $# == 0 || $# > 2 ))
	then
		echo "Usage: release.sh <RELEASE_VERSION> [<NEW_SNAPSHOT_VERSION>]"
		exit 0
elif ! [[ "$1" =~ ^([0-9]+)$ ]]
	then
		echo "Invalid release version: $1, expected x"
		exit 1
elif (( $# == 2 )) && ! [[ "$2" =~ ^([0-9]+)-SNAPSHOT$ ]] 
	then
		echo "Invalid snapshot version: $2, expected x-SNAPSHOT"
		exit 1
fi

if (( $# > 0 ))
	then
		echo "===== Releasing: $1 ====="
		mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$1
		git commit -a -m "Release $1"
		git tag -a $1 -m "Release $1"
		mvn clean deploy -Pio.inverno.release
fi

if (( $# == 2 ))
	then
		if ! [[ "$2" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)-SNAPSHOT$ ]] 
			then
				echo "bad version"
		fi
		echo "===== New Snapshot: $2 ====="
		mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$2
		git commit -a -m "$2"
fi

exit 0