REPORT_JENKINS="$1" # path to the log file
RESULT=$(cat "$2") # path to the stage result which failed or successed
SCRIPT_OUTPUT="$3" # the path of sum result like => 200 (100, 100)
LANG="$4" # which language is running currently

if [ "${RESULT}" = "Failed" ]; then
    echo "    => Running in ${LANG} language: Failed"  | tee -a "${REPORT_JENKINS}" 
    

elif [ "${RESULT}" = "Successed" ]; then 
    echo -n "    => Running in ${LANG} language: Successed ("  | tee -a "${REPORT_JENKINS}"
    echo -n $(head -n 1 ${SCRIPT_OUTPUT}) | tee -a "${REPORT_JENKINS}"
    echo ")"  | tee -a "${REPORT_JENKINS}"
    
else 
    echo "You wouldn't get here something get wrong in your script"    
fi
