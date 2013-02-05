#!/usr/bin/perl
#
# Count Log Lines v1.0 - David Mcanulty 2013 - tsaavik@hellspark.com
# Watches a logfile and prints the number of lines added to it per 'delay' cycle
#
# count-log filename [delay]

my $start_time=time();
my $start = localtime();

$num_args = $#ARGV + 1;
if ($num_args == 0) {
  print "\nWatches a logfile and prints the number of lines added to it per 'delay' cycle\n";
  print "\nUsage: $0 filename [delay]\n";
  exit;
}

$file=$ARGV[0];
if (! -e $file) {
   die "Sorry file: ($file) does not exist\n"
}

if ($num_args == 2) {
   $delay = $ARGV[1];
   if ((! $delay >= 1) || ($delay =~ m/\D/g)) {
      die "Sorry, delay must be a positive integer, you provided: ($delay)\n"
   }
}else{
   $delay=1;
}

$previous_lines = `wc -l $file`;  #seed
$line=999;
while (1) {
    if ($line > 200){
       $line=0;
       $current_time= localtime();
       print "\nStarted at: \t $start\n";
       print "current time: \t $current_time\n";
       print "Lines added to $file in the last $delay seconds: ";
    }
    sleep $delay;
    $current_lines = `wc -l $file`;
    print $current_lines - $previous_lines, " ";
    $previous_lines = $current_lines;
    $line++;
}

