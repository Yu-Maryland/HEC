# Makefile for C++ LP Extractor Library
CXX = g++
CPLEX_HOME = /export/jyin629/packages/cplex
ORTOOLS_HOME = /export/jyin629/packages/or-tools/install
CXXFLAGS = -std=c++17 -Wall -O2 -fPIC -I$(GUROBI_HOME)/include -I$(CPLEX_HOME)/cplex/include -I$(CPLEX_HOME)/concert/include -I$(ORTOOLS_HOME)/include
LDFLAGS = -shared -L$(GUROBI_HOME)/lib -lgurobi_c++ -lgurobi120 -L$(CPLEX_HOME)/cplex/lib/x86-64_linux/static_pic -L$(CPLEX_HOME)/concert/lib/x86-64_linux/static_pic -lilocplex -lcplex -lconcert -L$(ORTOOLS_HOME)/lib64 -lortools -lm -lpthread -ldl -Wl,-rpath,$(GUROBI_HOME)/lib -Wl,-rpath,/export/jyin629/packages/gcc/gcc-13.2.1/lib64 -Wl,-rpath,$(ORTOOLS_HOME)/lib64

# Library target
LIB_TARGET = liblp_extract.so
LIB_SOURCES = lp_extract.cpp

# Test executable
TEST_TARGET = test_lp_extract
TEST_SOURCES = test_main.cpp lp_extract.cpp

all: $(LIB_TARGET)

# Build shared library
$(LIB_TARGET): $(LIB_SOURCES)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(LIB_TARGET) $(LIB_SOURCES)

# Build test executable
$(TEST_TARGET): $(TEST_SOURCES)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $(TEST_SOURCES)

# Test the library
test: $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	rm -f $(LIB_TARGET) $(TEST_TARGET)

.PHONY: all test clean