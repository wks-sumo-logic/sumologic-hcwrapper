#!/usr/bin/env bash
###
### SCRIPTNAME [ options ] a wrapper for SumoLogic Customer Service health checks
###
###	-h | --help		display this message and exit
###	-v | --verbose		provide extra comments for verbose output
###	-d | --debug		run the script in complete verbose mode for debugging purposes
###	-r | --range		specify a range of time to look at [ default 31 days ]
###	-s | --sleep		specify a default time to sleep after each execution
###	-t | --target		specify a target system to look for
###	-c | --config		specify a config other than the default to use
###
### The script is run from: BASEDIR
### The script will cache files in the following directories:
###
###	+ TARGETDIR/xls -- output reports
###	+ TARGETDIR/log -- log files
###

display_help () {

  scriptname=$( basename $0 ) 
  startdir=$( ls -Ld $PWD ) 
  outputdir="/Users/$USER/Downloads/HealthCheckOutput"

  cat $0 | egrep -i '^###' | sed  's/^###//g' | \
  sed "s/SCRIPTNAME/$scriptname/g" | sed "s#TARGETDIR#$outputdir#g"
  exit 0

}

initialize_variables () {

  ${debugflag}

  base=$( ls -Ld $PWD )				&& export base

  scriptname="${0%.*}"				&& export scriptname
  cmddir=$( dirname $scriptname )		&& export cmddir
  bindir=$( cd $cmddir ; pwd -P . )		&& export bindir
  etcdir=$( cd $bindir/../etc/. ; pwd -P . )	&& export etcdir
  cfgdir=$( cd $bindir/../cfg/. ; pwd -P . )	&& export cfgdir

  datestamp=$(date '+%Y%m%d')          		&& export datestamp
  timestamp=$(date '+%H%M%S')          		&& export timestamp

  cscmd="/Applications/CS-Toolkit.app/Contents/Resources/app/cs-healthcheck/cs-healthcheck"
  export cscmd
  outputdir="/Users/$USER/Downloads/HealthCheckOutput"
  export outputdir

  xlsdir="$outputdir/$datestamp/xls"		&& export xlsdir
  logdir="$outputdir/$datestamp/log" 		&& export logdir

  targetcfg="$cfgdir/$scriptname.orgs.cfg"	&& export targetcfg
  credsfile="$etcdir/$scriptname.cred.cfg"	&& export credsfile

  timerange=${rangearg:-"31"}			&& export timerange	
  sleeptime=${sleeparg:-"15"}			&& export sleeptime
  targetarg=${targetarg:-""}			&& export targetarg

  verboseflag=${verboseflag:-"false"}		&& export verboseflag

}

initialize_environment () {

  ${debugflag}
  [ -f $credsfile ] && . $credsfile

  mkdir -p "$outputdir"
  mkdir -p "$logdir"
  mkdir -p "$xlsdir"

}

execute_checks () {

  ${debugflag}

  [ -f "$targetcfg" ] && {
    ( while read -r orgid myaws tagname
      do
        [ -z "${tagname##*$targetarg*}" ] && {

          logfile="$logdir/$myaws.$orgid.$datestamp.$timestamp.log"

          [ $verboseflag = "true" ] && echo "processing ... $tagname ... $myaws ... $orgid ..."
          $cscmd relative "$myaws" "$orgid" "$xlsdir" "${timerange}" > "$logfile" 2>&1 &

          [ $verboseflag = "true" ] && echo "... sleeping $sleeptime ..." 
          sleep "$sleeptime"

        }
      done 
    ) < "$targetcfg"
  }
}

main_logic () { 

  umask 022

  initialize_variables
  initialize_environment
  execute_checks

}
  
while getopts "hvdo:r:s:t:c:" options;
do
  case "${options}" in
    h) display_help ; exit 0 ;;
    v) verboseflag='true'   ; export verboseflag ;;
    d) debugflag='set -x'   ; export debugflag ;;
    r) rangearg=$OPTARG     ; export rangearg ;;
    s) sleeparg=$OPTARG     ; export sleeparg ;;
    t) targetarg=$OPTARG    ; export targetarg ;;
    *) display_help ; exit 0 ;;
  esac
done
shift $((OPTIND-1))

main_logic
