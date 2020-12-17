#!/bin/bash

while true; do
	echo " setup options:  "
	echo "[min] for minimal setup"
	echo "[yum] for minimal setup + update using yum"
	echo "[fpga] for minimal setup + fpga instances setup"
	read -p "[min/yum/fpga]       " option
	echo " "
	case $option in
		"min" | "yum" )
			if  [ $option == "yum" ] ; then
				echo -e ''$_{1..100}'\b=' ;
				echo "Starting yum update" ;
				echo -e ''$_{1..100}'\b=' ;
				yes | sudo yum update ;
				yes | sudo yum upgrade ;
				yes | sudo yum install nano ;
			else
				echo " No yum installation "
			fi
			echo -e ''$_{1..100}'\b=' ;
			echo " Starting Basic setup " ;
			echo -e ''$_{1..100}'\b=' ;
			git clone https://github.com/aws/aws-fpga.git $AWS_FPGA_REPO_DIR ;
			cd $AWS_FPGA_REPO_DIR                                         
    		source vitis_setup.sh
			break;;
		"fpga" ) 
			echo -e ''$_{1..100}'\b=' ;
			echo " Starting FPGA instances setup " ;
			echo -e ''$_{1..100}'\b=' ;
			git clone https://github.com/aws/aws-fpga.git $AWS_FPGA_REPO_DIR ;
			cd $AWS_FPGA_REPO_DIR                                         
    		source vitis_runtime_setup.sh
			echo -e ''$_{1..100}'\b=' ;
			echo " Starting Basic setup " ;
			echo -e ''$_{1..100}'\b=' ;
			cd $AWS_FPGA_REPO_DIR                                         
    		source vitis_setup.sh
			sleep 1m ;
			./host ./vadd.awsxclbin ;
			break;;
		* ) echo " Please put in correct option. " ;
			echo "setup options: " ;
			echo "[min] for minimal setup" ;
			echo "[yum] for minimal setup + update using yum" ;
			echo "[fpga] for minimal setup + fpga instances setup";;
	esac
done
echo " Done"
