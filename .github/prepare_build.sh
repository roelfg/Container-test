#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Need exactly one argument /path/to/Dockerfile"
	exit 1
fi

DOCKERFILE=$1

while read SRC DST; do
	mkdir -p $(dirname ${DOCKERFILE})$(dirname ${DST}) 
	rsync -av common/${SRC} $(dirname ${DOCKERFILE})${DST}
done < <(awk '/^COPY/{ print $2,$3 }' ${DOCKERFILE})
