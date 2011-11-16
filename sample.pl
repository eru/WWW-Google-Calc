use strict;
use warnings;
use WWW::Google::Calc;
use Encode;

my $cal = WWW::Google::Calc->new(lang => 'ja');

print encode('utf-8', $cal->calc('$100 in yen')) . "\n";
print encode('utf-8', $cal->calc('3フィートをメートルで')) . "\n";
