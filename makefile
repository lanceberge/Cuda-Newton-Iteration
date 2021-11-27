newton:
	make setup
	nvcc src/run.cu src/newton.cu src/complex.cu src/polynomial.cu -dc
	nvcc *.o -o bin/newton
	rm *.o

test:
	make setup
	nvcc src/test.cu src/newton.cu src/complex.cu src/polynomial.cu -dc
	nvcc *.o -o bin/test
	rm *.o
	./bin/test

setup:
	if [ ! -d "./bin" ]; then \
	mkdir bin; \
	fi

debug:
	nvcc -g -G src/test.cu src/newton.cu src/complex.cu src/polynomial.cu -dc
	nvcc -g -G *.o -o bin/test
	rm *.o

runAll:
	make runSmallTest
	make runBigTest
	make runBigTest2
	make runBigTest3

runSmallTest:
	./bin/newton 100 100 smallTest
	./bin/newton 100 100 smallTest step
	./bin/newton 100 100 smallTestL1 L1
	./bin/newton 100 100 smallTestL1 step L1

runBigTest:
	./bin/newton 500 500 bigTest
	./bin/newton 200 200 bigTest step
	./bin/newton 500 500 bigTestL1 L1
	./bin/newton 200 200 bigTestL1 step L1


runBigTest2:
	./bin/newton 500 500 bigTest2
	./bin/newton 200 200 bigTest2 step
	./bin/newton 500 500 bigTest2L1 L1
	./bin/newton 200 200 bigTest2L1 step L1

runBigTest3:
	./bin/newton 500 500 bigTest3
	./bin/newton 200 200 bigTest3 step
	./bin/newton 500 500 bigTest3L1 L1
	./bin/newton 200 200 bigTest3L1 step L1
