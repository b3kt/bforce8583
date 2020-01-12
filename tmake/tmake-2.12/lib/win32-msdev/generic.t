#!
#! This is a tmake template for building win32 applications.
#!
#${
   $project{'DEFINES_PREFIX'} = '/D ';
   $project{'INCLUDE_QUOTE'} = '"';
   $project{'INCLUDE_PREFIX'} = '/I ';
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
   $project{'TMAKE_REMOVE'} ||
      ($project{'TMAKE_REMOVE'} = '-del');
   $project{'TMAKE_LIB_CMD'} ||
      ($project{'TMAKE_LIB_CMD'} = $project{'TMAKE_LINK_CMD'});
   $project{'TMAKE_LFLAGS'} .= ' /out:"'.$project{'TARGET'}.'"';
   Project('debug:TMAKE_LFLAGS += /pdb:"$$_TARGET.pdb"');
   Project('debug:TMAKE_CLEAN += vc*.pdb $$_TARGET.ilk $$_TARGET.pdb' );
   Project('dll:TMAKE_CLEAN += $$_TARGET.lib $$_TARGET.exp');
   if (Project("TMAKE_LIB_FLAG")) {Project('TMAKE_LFLAGS += /implib:"$$_TARGET.lib"');}
#$}
#$ IncludeTemplate("../msvstudio/generic.t");
