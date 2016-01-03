#       AppleTalk MacIP Gateway
#
# Original work (c) 1997 Stefan Bethke. All rights reserved.
# Modified work (c) 2015 Jason King. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice unmodified, this list of conditions, and the following
#    disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
CC=gcc
CFLAGS=-c -Wall -DDEBUG -g

# Defaults are for a systemwide install of netatalk 3.x.
# To compile against a local, already-built netatalk 2.x source tree, do:
# export IFLAGS="-I/path/to/netatalk-2.x.y/include/ -I/path/to/netatalk-2.x.y/sys/"
# export NO_LINK_ATALK=1
# export LDFLAGS="/path/to/netatalk-2.x.y/libatalk/.libs/libatalk.a"

IFLAGS+=-I/usr/local/include
LDFLAGS+=-L/usr/local/lib
ifndef NO_LINK_ATALK
	LDFLAGS+=-latalk
endif

SOURCES=atp_input.c macip.c main.c nbp_lkup_async.c tunnel_linux.c util.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=macipgw
DESTDIR = /usr/local/sbin

all: $(SOURCES) $(EXECUTABLE)
    
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(IFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)

.c.o:
	$(CC) $(IFLAGS) $(CFLAGS) $< -o $@

clean:
	rm $(OBJECTS) $(EXECUTABLE)

install:
	cp $(EXECUTABLE) $(DESTDIR)
