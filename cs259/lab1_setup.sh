#!/bin/bash
echo -e ''$_{1..100}'\b=' ;
echo "setup shell for lab 1"
echo "quickstart shell should be sourced already"
echo -e ''$_{1..100}'\b=' ;
read -p "are you preparing for setup?[y/n] [no means go to emu]       " yn
case $yn in

	[Yy]* ) 
		cd $VITIS_DIR/examples/xilinx ;
		test -d cs-259-20f || git clone https://github.com/UCLA-VAST/cs-259-20f -o upstream ;
		cd cs-259-20f/lab1 ;
		pwd ;
		ls ;
		cd $VITIS_DIR/examples/xilinx ;
		git clone --single-branch https://github.com/AlicLi/HWrepo cs259 ;
		cd $VITIS_DIR/examples/xilinx/cs259/lab1 ;
		cp -r $VITIS_DIR/examples/xilinx/cs259/lab1 $VITIS_DIR/examples/xilinx/cs-259-20f ;
		rm -rf $VITIS_DIR/examples/xilinx/cs259 ;
		cd $VITIS_DIR/examples/xilinx/cs-259-20f/lab1 ;;
		

	[Nn]* ) 
		cd $VITIS_DIR/examples/xilinx/cs-259-20f/lab1 ;
		make clean ;
		make run TARGET=sw_emu DEVICE=$AWS_PLATFORM all ;
		read -p "do hardware simulation?[y/n]      " ynn
		case $ynn in
			[Yy]* ) make run TARGET=hw_emu DEVICE=$AWS_PLATFORM all ;
					find -name dot_prod_kernel_csynth.rpt -exec view {} \; -quit ;;
			[Nn]* ) echo "Skipping hardware simulation.";;
			* )  echo "Please answer yes or no.";;
		esac
		echo "Finished simulation.";;
	* ) echo "Please answer yes or no.";;
esac


