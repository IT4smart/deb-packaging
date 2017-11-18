#!/bin/bash
# Author: Raphael Lekies

BASEDIR="$PWD"
PKGNAME=$(basename "$BASEDIR")
OSDISTRO=$(basename $(dirname "$BASEDIR"))
DIST=${OSDISTRO//*-}

tmpdir=$(mktemp -d /tmp/git-tmp.XXXXXX) > /dev/null || exit 1


pushd "$tmpdir" || exit 1
git clone https://build.service:123456@devbase.it4s.eu/IT4S/StartPage.git .
git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
git tag -l | sort -u -r | while read TAG ; do
	if [ $NEXT ];then
		echo "${PKGNAME} (${NEXT#'v'}~deb8) ${DIST}; urgency=low"
	fi

	GIT_PAGER=cat git log --no-merges --format="  * %s%n" $TAG..$NEXT

    if [ $NEXT ];then
        echo " -- IT4S GmbH <support@it4s.eu>  $(git log -n1 --no-merges --format='%aD' $NEXT)"
    fi
    NEXT=$TAG
done
FIRST=$(git tag -l | head -1)
echo
echo "${PKGNAME} (${FIRST#'v'}~deb8) ${DIST}; urgency=low"
GIT_PAGER=cat git log --no-merges --format="  * %s%n" $FIRST
echo " -- IT4S  GmbH <support@it4s.eu> $(git log -n1 --no-merges --format='%aD' $FIRST)"
popd > /dev/null

rm -rf "$tmpdir"