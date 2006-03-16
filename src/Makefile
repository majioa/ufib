# this is a comment
SRC=vectors.asm core.asm main.asm
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
LFLAGS=-m -s0
RM=rm

# combined w/ next line will compile recently changed .asm files
%.o: %.asm
	$(AS) $(AFLAGS) $(SRCDIR)$<  -o > $(OBJDIR)$(<:.asm=.lst)
#	 mv $(SRCDIR).o $(OBJDIR)$(<:.asm=.o)

$(BIN): $(OBJ) # $(EXE) is dependent on all of the files in $(OBJ) and $(LDF) to exist
	$(LINK) $(LFLAGS) -o $(BINDIR)$@ $(OBJ) >$(BINDIR)$(BIN:.bin=.map)

$(HEX): $(OBJ)
	$(LINK) $(LFLAGS) -o $(BINDIR)$@ $(OBJ) >$(HEX:.hex=.map)
	${MAKE} -C ../obj all


.PHONY : all	 # .PHONY ignores files named all
all: $(HEX)	 # all is dependent on $(BIN) to be complete

.PHONY : clean	 # .PHONY ignores files named clean
clean:
	-$(RM) $(OBJ) *.*~ core    # '-' causes errors not to exit the process

