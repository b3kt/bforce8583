my $file_string = `find . -name tmake.conf`;
my @files = split(/\s/, $file_string);

foreach my $file(@files)
{
   -f "$file.orig" || `cp $file $file.orig`;
   print "Fixing $file\n";

   local *IN, *OUT;
   open (IN, "< $file.orig");
   open (OUT, "> $file");

   while (<IN>)
      {
      if ( /^CONFIG\s*=\w* qt\w*/ )
         {
         s/\bqt\b//g;
         }
      print OUT;
      }
   close(IN);
   close(OUT);
   system ("diff $file $file.orig");
}

