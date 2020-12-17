#!/bin/bash
echo -e ''$_{1..100}'\b=' ;
echo "setup shell for proj"
echo "quickstart shell should be sourced already"
echo -e ''$_{1..100}'\b=' ;
read -p "are you preparing for setup?[y/n/s] [no means go to emu] [s to skip swsim]       " yn
case $yn in
	"base" ) 
		cd ~/PHT ;
		git pull ;
		rm -rf $VITIS_DIR/examples/xilinx/CS259Proj ;
		unset SEQUENTIAL ;
		echo "Baseline simulation.";
		cp -r ~/PHT/CS259Proj $VITIS_DIR/examples/xilinx/ ;
		cd $VITIS_DIR/examples/xilinx/CS259Proj ;
		make hls ;
		find -name CnnKernel_csynth.rpt -exec view {} \; -quit ;;
	"c" ) 
		cd $VITIS_DIR/examples/xilinx ;
		rm -rf CS259Proj ;
		unset SEQUENTIAL ;
		cp -r ~/PHT/CS259Proj $VITIS_DIR/examples/xilinx/ ;
		cd $VITIS_DIR/examples/xilinx/CS259Proj ;;
	[Yy]* ) 
		cd ~/PHT ;
		# rm -rf PHT ;
		git pull ;
		cd $VITIS_DIR/examples/xilinx ;
		pwd ;
		ls ;
		# cd $VITIS_DIR/examples/xilinx ;
		test -d $VITIS_DIR/examples/xilinx/CS259Proj || cp -r ~/PHT/CS259Proj $VITIS_DIR/examples/xilinx/ ;
		cp ~/PHT/CS259Proj/working/xilinx.cpp $VITIS_DIR/examples/xilinx/CS259Proj/xilinx.cpp ;
		cp ~/PHT/CS259Proj/cnnConfig.h $VITIS_DIR/examples/xilinx/CS259Proj/cnnConfig.h ;
		cd $VITIS_DIR/examples/xilinx/CS259Proj ;;
		

	[Nn]* ) 
		cd $VITIS_DIR/examples/xilinx/CS259Proj ;
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
		unset SEQUENTIAL ;
		echo "Skip to hls make.";
		cd $VITIS_DIR/examples/xilinx/CS259Proj ;
		make hls ;
		find -name CnnKernel_csynth.rpt -exec view {} \; -quit ;;
	* ) echo "Please answer yes or no.";;
esac


