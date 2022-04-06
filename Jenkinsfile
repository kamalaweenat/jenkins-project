pipeline { 
    agent { node { label 'slave01' } }
    //agent { node { label 'master' } }
    //agent any

    environment {
        // Path to the log file
        REPORT_JENKINS_PATH="${HOME}/Documents/Deployment"
        // Full path
        REPORT_JENKINS="${REPORT_JENKINS_PATH}/report"
        // path to the Result of stage build file (Failed or Successed)
        STAGE_RESULT="${REPORT_JENKINS_PATH}/tmp_stage_result"
        // path to the Result of stage build file (Failed or Successed)
        SCRIPT_OUTPUT="${REPORT_JENKINS_PATH}/tmp_script_output"
        // all script files are the same name  
        SCRIPT_NAME="sum"
        // python interpreter
        PYTHON="python3"
         // shell terminal
        SHELL="bash"
        // C compiler
        GCC="gcc"       
        
    }

/*
    parameters {
        choice(
            name: 'Language',
            choices: ['All', 'C', 'Bash', 'Python'],
            description: 'Which code language you want to compile the program'
            )
    }
*/

    stages {

        stage('Clone Sources') {
            steps {
                checkout scm
            } 
        }

        stage('Build') {
            steps {
                echo 'Build process..'           
                sh '''	    	                     
                    chmod 755 "${WORKSPACE}"/scripts/*    
                    chmod 755 "${WORKSPACE}"/report_helper.sh  
                    
                    mkdir -p "${REPORT_JENKINS_PATH}"                                     
                    if [ ! -f "${REPORT_JENKINS}" ]; then                      
                        touch "${REPORT_JENKINS}"                        
                    fi 
                    echo "" >> "${REPORT_JENKINS}" 
                    echo "----------------------------------------------------------" >> "${REPORT_JENKINS}" 
                    date >> "${REPORT_JENKINS}"
                    echo "----------------------------------------------------------" >> "${REPORT_JENKINS}" 
                    echo "[USER="$USER" | JOB_NAME="$JOB_NAME" | BUILD_NUMBER="$BUILD_NUMBER"]" >> "${REPORT_JENKINS}"
                    echo "Input params: (${FirstNumber}, ${SecondNumber})" >> "${REPORT_JENKINS}"
                '''
             }
        }

        stage("Env Variables") {
            steps {
                sh "printenv"
            }
        }  
             
        stage('Run In C') {
            when {
                expression { 
                   return "$Language" == 'All' || "$Language" == 'C'
                }
            }
            steps {   
                         
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    sh '''
                        echo 'Failed' > "${STAGE_RESULT}"
                        cd "${WORKSPACE}/scripts"                        
                        type ${GCC} || exit 1                        
                        ${GCC} "${SCRIPT_NAME}".c -o "${SCRIPT_NAME}"_bin
                        output=$(./"${SCRIPT_NAME}"_bin  "$FirstNumber" "$SecondNumber") || exit 2
                       
                        echo -n "${output}" | tee "${SCRIPT_OUTPUT}"
                        echo 'Successed' | tee "${STAGE_RESULT}"
                    '''
                }                
                sh '''   
                        ${WORKSPACE}/report_helper.sh ${REPORT_JENKINS} ${STAGE_RESULT} ${SCRIPT_OUTPUT} "C"
                    '''           
            }
        }

        stage('Run In Bash') {
            when {
                expression { 
                   return "$Language" == 'All' || "$Language" == 'Bash'
                }
            }
            steps { 
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    sh '''
                        echo "Failed" > ${STAGE_RESULT}
                        cd "${WORKSPACE}/scripts"

                        type ${SHELL} || exit 1
                        output=$(./"${SCRIPT_NAME}".sh "$FirstNumber" "$SecondNumber") || exit 2
                        
                        echo -n "${output}" | tee "${SCRIPT_OUTPUT}"
                        echo "Successed" | tee "${STAGE_RESULT}"  
                    ''' 
                }  
                 sh '''                       
                        ${WORKSPACE}/report_helper.sh ${REPORT_JENKINS} ${STAGE_RESULT} ${SCRIPT_OUTPUT} "Bash"
                    ''' 
            }
        }

        stage('Run In Python') {
            when {
                expression { 
                   return "$Language" == 'All' || "$Language" == 'Python'
                }
            }
            steps {  
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {                       
                    sh '''
                        echo "Failed" > ${STAGE_RESULT}

                        type ${PYTHON} || exit 1                                                
                        output=$(${PYTHON} "${WORKSPACE}"/scripts/"${SCRIPT_NAME}".py "$FirstNumber" "$SecondNumber") || exit 2  
                         
                        echo -n "${output}" | tee "${SCRIPT_OUTPUT}"                   
                        echo "Successed" | tee "${STAGE_RESULT}"
                    '''
                }
                 sh '''                       
                        ${WORKSPACE}/report_helper.sh ${REPORT_JENKINS} ${STAGE_RESULT} ${SCRIPT_OUTPUT} "Python"
                    '''
            }
        }
    }

     post {   
		always {
			sh 'echo -n "[Finished pipline: " >> "${REPORT_JENKINS}"'         
		}   
		success {  
            sh 'echo  "Successed]" >> "${REPORT_JENKINS}"'  
		}   
		failure {
            sh 'echo  "Failed]" >> "${REPORT_JENKINS}"'   
		}   
		unstable {  
           sh 'echo  "Unstable]" >> "${REPORT_JENKINS}"'   			
		}   
        cleanup{
            echo "Cleanup tmp files also output files from gcc compiler" 
            sh '''
                rm -rf ${STAGE_RESULT}
                rm -rf ${SCRIPT_OUTPUT}
                cd "${WORKSPACE}/scripts"
                rm -rf "${SCRIPT_NAME}"_bin
            '''
             
        } 
   }
}
