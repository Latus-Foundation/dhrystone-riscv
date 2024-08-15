CC = clang

DHRY-LFLAGS =

DHRY-CFLAGS := -O3 -DTIME -DNOENUM -Wno-implicit -save-temps
DHRY-CFLAGS += -fno-common -falign-functions=4	# -fno-builtin-printf

RV32I_CFLAGS := --target=riscv32 -march=rv32i -msoft-float -I/opt/riscv32/riscv32-unknown-elf/include -I/opt/riscv32/lib/gcc/riscv32-unknown-elf/13.2.0/include -lc -lm -lgcc

#Uncomment below for FPGA run, default DHRY_ITERS is 2000 for RTL
#DHRY-CFLAGS += -DDHRY_ITERS=20000000

SRC = dhry_1.c dhry_2.c strcmp.S
HDR = dhry.h
PLATFORM =  -nostartfiles -Tlink.ld # -nostdlib -mcmodel=medany -mabi=ilp32 -march=rv32i

all: dhrystone

override CFLAGS += $(DHRY-CFLAGS) $(XCFLAGS) $(RV32I_CFLAGS) $(PLATFORM) -Xlinker --defsym=__stack_size=0x800 -Xlinker --defsym=__heap_size=0x1000
dhrystone: $(SRC) $(HDR)
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) $(LOADLIBES) $(LDLIBS) -o $@

clean:
	rm -f *.i *.s *.o dhrystone dhrystone.hex


#CC = clang
#CFLAGS = --target=riscv32 -march=rv32i -msoft-float -I/opt/riscv32/riscv32-unknown-elf/include -I/opt/riscv32/lib/gcc/riscv32-unknown-elf/13.2.0/include -O3 -DTIME -DNOENUM -Wno-implicit -save-temps -fno-common -falign-functions=4
#LDFLAGS = -Wl,--wrap=printf -Wl,--wrap=strcmp -Wl,--wrap=memcpy -Wl,--wrap=memset

#all: my_program

#my_program: main.o custom_printf.o custom_strcmp.o custom_memcpy.o custom_memset.o
#	$(CC) $(LDFLAGS) -o $@ $^

#%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

#clean:
#	rm -f *.o my_program