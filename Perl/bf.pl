use strict;
use warnings;

my @data;
my $p = 0;
my $s;

sub process {
    my $loc = shift;
    my $t = $loc;
    while ($t < length($s)) {
        my $c = substr($s, $t, 1);
        if ($c eq '+') { $data[$p]++; }
        if ($c eq '-') { $data[$p]--; }
        if ($c eq '>') { $p++; }
        if ($c eq '<') { $p--; }
        if ($c eq ',') {
            my $cc = getc(STDIN);
            $data[$p] = ord($cc);
        }
        if ($c eq '.') { printf("%c", $data[$p]); }
        if ($c eq '[') { $t = process($t + 1); }
        if ($c eq ']' && $data[$p] != 0) {
            if ($data[$p] != 0) { return process($loc); }
            return $t;
        }
        $t++;
    }
    return length($s);
}

sub main {
    @data = (0) x 30000;
    my $fileName = $ARGV[0];
    open(my $file, '<', $fileName) or die "Failed to open the file.";
    {
        local $/;
        $s = <$file>;
    }
    process(0);
    close($file);
}

main();

