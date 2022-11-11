
# Useful CFLAGS values:
#    Basic aarch64 target:	-march=armv8-a
#    aarch64 with SVE:		-march=armv8.5-a+sve
#    aarch64 with SVE2:		-march=armv8.5-a+sve2
#
# Note that armv9-a does not appear to be accepted
# by some versions of gcc that can emit sve2 
# instructions (contrary to the docs).
#
CFLAGS = -g -O3 -march=armv8-a
RUNTOOL = 
TIMETOOL = time
BINARIES = image-adjust

all-test:		${BINARIES}
			echo "Making and testing all versions..."
			${RUNTOOL} ./image-adjust tests/input/bree.jpg 1.0 1.0 1.0 tests/output/bree1a.jpg
			${RUNTOOL} ./image-adjust tests/input/bree.jpg 0.5 0.5 0.5 tests/output/bree1b.jpg
			${RUNTOOL} ./image-adjust tests/input/bree.jpg 2.0 2.0 2.0 tests/output/bree1c.jpg

all:			${BINARIES}

image-adjust:		image-adjust.c adjust_channels.o
			gcc ${CFLAGS_MAIN} image-adjust.c adjust_channels.o -o image-adjust

djust_channels.o:	adjust_channels.c
			gcc ${CFLAGS} -c adjust_channels.c -o adjust_channels.o

clean:			
			rm ${BINARIES} *.o tests/output/bree??.jpg tests/output/montage.jpg || true


