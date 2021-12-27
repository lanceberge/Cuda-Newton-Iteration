newton:
	make setup
	nvcc src/main.cu src/newton.cu src/complex.cu src/polynomial.cu -O3 -lpng -o bin/newton -rdc=true

test:
	make setup
	nvcc src/test.cu src/newton.cu src/complex.cu src/polynomial.cu -o bin/test -rdc=true
	./bin/test

debug:
	nvcc src/main.cu src/newton.cu src/complex.cu src/polynomial.cu -lpng -g -G -o bin/newton -rdc=true

setup:
	if [ ! -d "./bin" ]; then \
	mkdir bin; \
	fi

runAll:
	make runSmallTest
	make runBigTest
	make runBigTest2

runSmallTest:
	./bin/newton smallTest

runBigTest:
	./bin/newton bigTest


runBigTest2:
	./bin/newton bigTest2

name = bigTest

movie:
	ffmpeg -y -start_number 0 -r 24 -i fractals/$(name)Step-%d.png -b:v 8192k -c:v mpeg4 fractals/$(name).mp4
	rm fractals/*Step*
