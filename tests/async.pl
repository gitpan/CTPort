# tests async functions

# include CTPort.pm module in perl include path, this way we dont have to
# "make install" every time we edit CTPort.pm

BEGIN {
  push(@INC, "..");
};

# note this line would be "use Telephony::CTPort" if module was installed
use CTPort; 

$ctport = new Telephony::CTPort(1200); # first port of CT card

sub wait_for_my_event($);

my $its = 0;

while(1) {

    print "testing start_timer_async...\n";

    $ctport->start_timer_async(2);
    
    my $ret = 1;
    while ($ret) {
	($handle, $event) = $ctport->wait_for_event();
	print "[$handle] $event\n";

	if ($event eq "timer") {
	    $ret = 0;
	}
    }
    
    print "testing stop_timer()...\n";

    $ctport->start_timer_async(3);
    sleep(1);
    $ctport->stop_timer();
    
    print "testing play_tone_async() and stop_tone()...\n";

    $ctport->play_tone_async("dial");
    sleep(3);
    $ctport->stop_tone();

    $ctport->play_tone_async("busy");
    wait_for_my_event("toneend");
    $ctport->play_tone_async("busy");
    wait_for_my_event("toneend");

    $ctport->play_tone_async("ringback");
    wait_for_my_event("toneend");
    $ctport->play_tone_async("ringback");
    wait_for_my_event("toneend");

    $its++;
    print "its = $its\n";
}

sub wait_for_my_event($) {
    my ($ev) = @_;

    while (1) {
	($handle, $event) = $ctport->wait_for_event();
	print "[$handle] $event\n";

	if ($event eq $ev) {
	    return;
	}
    }
}
