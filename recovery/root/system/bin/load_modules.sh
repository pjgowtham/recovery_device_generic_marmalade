#!/sbin/sh

# The below variables shouldn't need to be changed
# unless you want to call the script something else
SCRIPTNAME="load_modules"
LOGFILE=/tmp/recovery.log

# Set default log level
DEFAULT_LOGLEVEL=1
# 0 Errors only
# 1 Errors and Information
# 2 Errors, Information, and Debugging
CUSTOM_LOGLEVEL=$(getprop $SCRIPTNAME.loglevel)
if [ -n "$CUSTOM_LOGLEVEL" ]; then
    __VERBOSE="$CUSTOM_LOGLEVEL"
else
    __VERBOSE="$DEFAULT_LOGLEVEL"
fi

# Exit codes:
# 0 Success
# 1 Unknown encryption type
# 2 Temp Mount Failure

# Function for logging to the recovery log
log_print()
{
	# 0 = Error; 1 = Information; 2 = Debugging
	case $1 in
		0|error)
			LOG_LEVEL="E"
			;;
		1|info)
			LOG_LEVEL="I"
			;;
		2|debug)
			LOG_LEVEL="DEBUG"
			;;
		*)
			LOG_LEVEL="UNKNOWN"
			;;
	esac
	if [ $__VERBOSE -ge "$1" ]; then
		echo "$LOG_LEVEL:$SCRIPTNAME::$2" >> "$LOGFILE"
	fi
}

finish()
{
	log_print 1 "$SCRIPTNAME complete."
	exit 0
}

load_module()
{
	is_module_loaded=$(lsmod | grep "$1")
	if [ -n "$is_module_loaded" ]; then
		log_print 1 "$1 module already loaded. Proceeding..."
	else
		insmod "/v/lib/modules/$1.ko"
		is_module_loaded=$(lsmod | grep "$1")
		if [ -n "$is_module_loaded" ]; then
			log_print 1 "Loaded $1 module."
		else
			log_print 1 "Unable to load $1 module."
		fi
	fi
}

log_print 1 "Running $SCRIPTNAME script for TWRP..."

load_module "aw8697"
load_module "focaltech_fts_zf"
load_module "texfat"
load_module "tntfs"

finish
