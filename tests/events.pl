BEGIN {
  push(@INC, "..");
};

use CTPort;

$ctport = new Telephony::CTPort(1200); # first port of CT card

while(1) {
    ($handle, $event) = $ctport->wait_for_event();
    print "[$handle] $event\n";
}
