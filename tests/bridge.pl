# bridge.pl - testing bridging ports

BEGIN {
  push(@INC, "..");
};

use CTPort;

$ctport = new Telephony::CTPort(1200); # first port of CT card

$ctport->bridge(4);
sleep(5);
$ctport->unbridge(4);
