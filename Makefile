CXX = g++
CXXFLAGS = -g
LIBS = -lgtest -lpthread -lgtest_main
INCS = -I./
OBJS = testfile.o

utest: $(OBJS)
	$(CXX) $(CXXFLAGS) $(INCS) -o utest test.cpp $(OBJS) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

clean:
	rm -f *.o utest.xml utest