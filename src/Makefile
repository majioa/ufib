# this is a comment
SRC=ufib.asm
OBJ=$(SRC:.asm=.o) # replaces the .asm from SRC with .o
BIN=ufib.bin

AS=cfasm
CC=cfcc
LINK=cflink
BINC=binc
AFLAGS=-l -o $<
CFLAGS=
LFLAGS=-m -b -r0 -o $@
#AFLAGS=-li $(SRC:.asm=.lst) -o $@ -g $< -proc $(PROC)
#CFLAGS=-L .  -proc $(PROC) -o $@ -g $<
#LFLAGS=-Map $(EXE:.dxe=.map) -L. -S -s -o $@ -T $(LDF)
RM=rm

# combined w/ next line will compile recently changed .asm files
%.o: %.asm
	$(AS) $(AFLAGS) > $(SRC:.asm=.lst)

%.o: %.c
	$(CC) $(CFLAGS)

$(BIN): $(OBJ) # $(EXE) is dependent on all of the files in $(OBJ) and $(LDF) to exist
	$(LINK) $(LFLAGS) $(OBJ) >$(BIN:.bin=.map)

.PHONY : all	 # .PHONY ignores files named all

all: $(BIN)	 # all is dependent on $(BIN) to be complete

.PHONY : clean	 # .PHONY ignores files named clean
clean:
	-$(RM) $(OBJ) core    # '-' causes errors not to exit the process

