# this is a comment
SRC=ufib.asm
OBJ=$(SRC:.asm=.o) # replaces the .asm from SRC with .o
BIN=ufib.bin
HEX=$(BIN:.bin=.hex)
#SRCDIR=../src/
#OBJDIR=../obj/
#BINDIR=../bin/

AS=cfasm.exe
CC=cfcc.exe
LINK=cflink.exe
BINC=binc.exe
AFLAGS=-l
CFLAGS=
LFLAGS=-m
RM=rm

# combined w/ next line will compile recently changed .asm files
%.o: %.asm
	$(AS) $(AFLAGS) $(SRCDIR)$<  -o > $(OBJDIR)$(<:.asm=.lst)

$(HEX): $(OBJ)
	$(LINK) $(LFLAGS) -s0 -o $(BINDIR)$@ $(OBJ) >$(BINDIR)$(HEX:.hex=.map)

$(BIN): $(SRC) # $(BIN) is dependent on all of the files in $(OBJ) to exist
	$(AS) $(SRCDIR)$<  -b


.PHONY : all	 # .PHONY ignores files named all
all: $(HEX) $(BIN)	 # all is dependent on $(BIN) and $(HEX)) to be complete

.PHONY : clean	 # .PHONY ignores files named clean
clean:
	-$(RM) $(OBJ) *.*~ core    # '-' causes errors not to exit the process

