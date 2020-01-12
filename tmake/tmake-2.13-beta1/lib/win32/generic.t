#!
#! This is a tmake template for building win32 applications.
#!
#${
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
   $project{'OUTTYPE'} = 'nmake';
   $project{'TMAKE_REMOVE'} ||
      ($project{'TMAKE_REMOVE'} = '-del');
   $project{'TMAKE_LIB_CMD'} ||
      ($project{'TMAKE_LIB_CMD'} = $project{'TMAKE_LINK_CMD'});
#$}
#$ IncludeTemplate("../$project{'OUTTYPE'}/$project{'TEMPLATE'}.t");
