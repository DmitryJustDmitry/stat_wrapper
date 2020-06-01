PROG = stat_wrapper
JSONCPPPATH = /usr/include/jsoncpp

ifndef ISP_PATH
  $(error Set ISP_PATH to fuzzer bins first)
endif

#ifeq "$(findstring isp-, $(CXX))" ""   
#  $(error Set CXX to the one of the isp-* c++ compilers first)
#endif

ifeq "$(shell test -e $(JSONCPPPATH) || echo 1)" "1"   
  $(error You must install libjsoncpp-dev)
endif

CXXFLAGS += -g -O3 -std=c++11

CPPFLAGS += \
	-I. \
	-I/usr/include/jsoncpp

LDLIBS = -ljsoncpp

LDFLAGS += -L/usr/local/lib $(LDLIBS)

all: $(PROG)
	@echo $(PROG) compilation success!
	
SRCS = ReadJsonCfg.cpp
OBJS=$(subst .cc,.o, $(subst .cpp,.o, $(SRCS)))

$(PROG): $(OBJS)	
	$(CXX) $^ $(LDFLAGS) -o $@

clean:
	rm -f $(OBJS) $(PROG) ./.depend

#depend: .depend

#.depend: $(SRCS)
#	rm -f ./.depend
#	$(CXX) $(CPPFLAGS) -MM $^ >  ./.depend;

#include .depend
