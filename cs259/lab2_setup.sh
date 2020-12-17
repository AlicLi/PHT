#!/bin/bash
echo -e ''$_{1..100}'\b=' ;
echo "setup shell for lab 2"
echo "quickstart shell should be sourced already"
echo -e ''$_{1..100}'\b=' ;
read -p "are you preparing for setup?[y/n/s] [no means go to emu] [s to skip swsim]       " yn
case $yn in

	[Yy]* ) 
		cd $VITIS_DIR/examples/xilinx ;
		test -d cs-259-20f || git clone https://github.com/UCLA-VAST/cs-259-20f -o upstream ;
		cd cs-259-20f/lab2 ;
		pwd ;
		ls ;
		cd $VITIS_DIR/examples/xilinx ;
		git clone --single-branch https://github.com/AlicLi/HWrepo cs259 ;
		cd $VITIS_DIR/examples/xilinx/cs259/lab2 ;
		cp -r $VITIS_DIR/examples/xilinx/cs259/lab2/xilinx.cpp $VITIS_DIR/examples/xilinx/cs-259-20f/lab2 ;
		rm -rf $VITIS_DIR/examples/xilinx/cs259 ;
		cd $VITIS_DIR/examples/xilinx/cs-259-20f/lab2 ;;
		

	[Nn]* ) 
		cd $VITIS_DIR/examples/xilinx/cs-259-20f/lab2 ;
		# unset SEQUENTIAL
		unset SEQUENTIAL
		make swsim 
		# make run TARGET=sw_emu DEVICE=$AWS_PLATFORM all ;
		read -p "do hls simulation?[y/n]      " ynn
		case $ynn in
			[Yy]* ) make hls ;
					find -name CnnKernel_csynth.rpt -exec view {} \; -quit ;
					echo "Along with hardware description generation, HLS step also provides performance estimation.";;
			[Nn]* ) echo "Skipped.";;
			* )  echo "Please answer yes or no.";;
		esac
		echo "Finished simulation.";;
	"s" ) 
		echo "Skip to hls make.";
		cd $VITIS_DIR/examples/xilinx/cs-259-20f/lab2 ;
		make hls ;
		find -name CnnKernel_csynth.rpt -exec view {} \; -quit ;;
	* ) echo "Please answer yes or no.";;
esac


