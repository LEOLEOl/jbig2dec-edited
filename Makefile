BUILD_THREAD = thread
CC = gcc

SOURCE += $(wildcard *.c)
HEADER += $(wildcard ../headers/*.h)
HEADER += $(wildcard ./*.h)

LOCAL_INC = .
OBJECT = $(SOURCE:.c=.o)
TARGET = run
FLAGS  +=  -c -g -lgcov--coverage -lpng
CFLAGS += -fprofile-arcs -ftest-coverage
DFLAGS += -fprofile-arcs -ftest-coverage
libs_for_gcc = 
thread_libs += -lpthread -lpng
RM     = -rm -rf
FLAGS += $(addprefix -I, $(LOCAL_INC))
CURR_DIR=$(strip $(shell pwd))

allall: $(TARGET)
run: $(OBJECT)


	$(CC) -o $(TARGET) $(OBJECT) $(thread_libs) $(DFLAGS)

%.o: %.c
	$(CC) $(FLAGS) $(CFLAGS) $< -o $@
	
.PHONY:clean
clean:
	$(RM) $(OBJECT) $(TARGET) *.gcno *.gcda
	
