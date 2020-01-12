#!
#! This is a tmake template for MS Visual Studio DSW files
#!
#${
   StdInit();
   $project{'TMAKE_OUTEXT'} = ".dsw"; 
#$}
Microsoft Developer Studio Workspace File, Format Version 6.00
# WARNING: DO NOT EDIT OR DELETE THIS WORKSPACE FILE!

#${
$prev_dsp="";
foreach ( split(/\s+/,$project{"SUBDIRS"}) ) {
@p = split(/\//);
$dsp = $p[$#p];
$text .= '###############################################################################'."\n";
$text .= "\n";
$text .= 'Project: "'.$dsp.'"=".\\'.join('\\', @p).'\\'.$dsp.'.dsp" - Package Owner=<4>'."\n";
$text .= "\n";
$text .= 'Package=<5>'."\n";
$text .= '{{{'."\n";
$text .= '}}}'."\n";
$text .= "\n";
$text .= 'Package=<4>'."\n";
$text .= '{{{'."\n";
if ( $prev_dsp ) {
   $text .= '    Begin Project Dependency'."\n";
   $text .= '    Project_Dep_Name '.$prev_dsp."\n";
   $text .= '    End Project Dependency'."\n"; }
$text .= '}}}'."\n";
$text .= "\n";
$prev_dsp = $dsp; }
$text .= '###############################################################################'."\n";
#$}
Global:

Package=<5>
{{{
}}}

Package=<3>
{{{
}}}

###############################################################################

