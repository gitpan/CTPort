#!/usr/bin/perl -w
# dialout.pl
# David Rowe 19/10/01
#
# Demonstrates dialing out.
 
# ctserver - client/server library for Computer Telephony programming in Perl
# Copyright (C) 2001 David Rowe david@voicetronix.com.au
# see COPYING.TXT

use Telephony::CTPort;

$ctport = new Telephony::CTPort(1200); 
sleep(1);
$ctport->off_hook;            # take off hook
$foo=$ctport->call("12");          # dial extension 11
print "$foo \n";
if ($foo =~/OK/){
$ctport->play("1 2 3 4 5 6 7 8 9 0");
$ctport->play("1 2 3 4 5 6 7 8 9 0");
$ctport->play("1 2 3 4 5 6 7 8 9 0");
}
$ctport->on_hook;







