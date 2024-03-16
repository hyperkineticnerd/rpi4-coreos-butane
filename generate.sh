# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`
DESTDIR='/mnt/nfs/web/coreos'

# Loop through all Butane files and generate Ignition files
for f in $(find ${SCRIPTPATH} -iname \*.bu.yaml); do
    w=${f#${SCRIPTPATH}/}
    echo Generating $w
    mkdir -p ${DESTDIR}/$(dirname $w)
    butane -s -d . "$f" -o ${DESTDIR}/"${w%.bu.yaml}.ign"
done
