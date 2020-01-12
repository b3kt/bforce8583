#!
#! This is a tmake template for building unix applications.
#!
#${
   ComputeConfigDependencies();
   StdInit();
   ComputeUnixTargetVersions();
#$}
#$ IncludeTemplate("../kdevelop/$project{'TEMPLATE'}.t");
