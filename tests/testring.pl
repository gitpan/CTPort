# testring.pl
# David Rowe 31/3/03
# loop start port test code, waits for ring then answers

BEGIN {
  push(@INC, "..");
};

use CTPort;

my $its = 0;

$ctport = new Telephony::CTPort(1210);
$ctport->on_hook();    

while(1) {
    $ctport->wait_for_ring();
    $ctport->off_hook();
    sleep(2);
    $ctport->on_hook();    
    $its++;
    print "calls answered: $its\n";
}
