# ringstat.pl - testing station ringing

BEGIN {
  push(@INC, "..");
};

use CTPort;

$ctport = new Telephony::CTPort(1200);

print "ha\n";
$ctport->start_ring_once_async();
print "he\n";
$ctport->start_timer_async(4);

my $rings = 0;
my $its = 0;

while (1) {
    ($handle, $event) = $ctport->wait_for_event();
    print "[$handle] $event\n";

    if ($event eq "pickup") {
	$ctport->stop_timer();

	$ctport->play_tone_async("dial");
	wait_for_hangup();
	$ctport->stop_tone();

	$ctport->start_ring_once_async();
	$ctport->start_timer_async(1);
	$rings = 0;

	$its++;
	print "calls made $its\n";
    }

    if ($event eq "timer") {
	$rings++;
	if ($rings == 4) {
	    $ctport->stop_ring();
	}
	else {
	    $ctport->start_ring_once_async();
	    $ctport->start_timer_async(4);
	}
    }
}

sub wait_for_hangup() {
    while (1) {
	($handle, $event) = $ctport->wait_for_event();
	print "[$handle] $event\n";

	if ($event eq "hangup") {
	    return;
	}
    }
}
