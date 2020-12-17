#!/bin/bash
VITIS_DIR="/home/centos/src/project_data/aws-fpga/Vitis"

while true; do
	echo " compile options:  " ;
	echo "[hello] for hello_world hardware build test" ;
	echo "[build] for self build test" ;
	echo "[hwemu] for self hardware emulation test" ;
	echo "[swemu] for self software emulation test" ;
	read -p "[hello/build/hwemu/swemu]       " option ;
	echo " " ;
	case $option in
		"hello" ) 
			echo -e ''$_{1..100}'\b=' ;
			echo " Starting hello world test " ;
			echo -e ''$_{1..100}'\b=' ;
			cd $VITIS_DIR/examples/xilinx/hello_world ;
			pwd ;          
		    make clean ;                                                             
		    make TARGET=hw DEVICE=$AWS_PLATFORM all ;
		    echo -e ''$_{1..100}'\b=' ;
		    echo " Completed hello world test " ;   
		    echo -e ''$_{1..100}'\b=' ;
		    cd - ;
			break;;
		"build" ) 
			echo -e ''$_{1..100}'\b=' ;
			echo "Starting self test build make" ;
			echo -e ''$_{1..100}'\b=' ;
			read -p "[TARGET DEVICE DIR after VITIS_DIR/]       " target device directory ;
			echo "Chosen TARGET=$target, Chosen DEVICE=$device" ;
			cd $VITIS_DIR/$directory ;   
			pwd ;        
			make clean ;
			make TARGET=$target DEVICE=$device all ;
			echo -e ''$_{1..100}'\b=' ;
		    echo " Completed self test " ;   
		    echo -e ''$_{1..100}'\b=' ;
		    cd -
			break;;
		"hwemu" ) 
			echo -e ''$_{1..100}'\b=' ;
			echo "Starting self hardware emulation make" ;
			echo -e ''$_{1..100}'\b=' ;
			read -p "[DIR after VITIS_DIR/]       " directory ;
			echo "Chosen DIR=$directory" ;
			cd $VITIS_DIR/$directory ;      
			pwd ;    
			make clean ;
			make run TARGET=hw_emu DEVICE=$AWS_PLATFORM all ;    

			echo -e ''$_{1..100}'\b=' ;
		    echo " Completed " ;   
		    echo -e ''$_{1..100}'\b=' ;
		    cd - ;
			break;;
		"swemu" ) 
			echo -e ''$_{1..100}'\b=' ;
			echo "Starting self software emulation make" ;
			echo -e ''$_{1..100}'\b=' ;
			read -p "[DIR after VITIS_DIR/]       " directory ;
			echo "Chosen DIR=$directory" ;
			cd $VITIS_DIR/$directory ;           
			pwd ;
			make clean ;
			make run TARGET=sw_emu DEVICE=$AWS_PLATFORM all ;   
			echo -e ''$_{1..100}'\b=' ;
		    echo " Completed" ;   
		    echo -e ''$_{1..100}'\b=' ;
		    cd - ;
			break;;
		* ) 
			echo " compile options:  " ;
			echo "[hello] for hello_world hardware build test" ;
			echo "[build] for self build test" ;
			echo "[hwemu] for self hardware emulation test" ;
			echo "[swemu] for self software emulation test" ;;
	esac
done
echo " Done"
