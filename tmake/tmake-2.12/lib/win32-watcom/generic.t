#!
#! This is a tmake template for building win32-msvc applications.
#!
#${
   $project{'OBJ_IMPL_OUT'} = '-o$@ $<';
   $project{'TMAKE_REMOVE'} = '-del';
   $project{'DEFINES_PREFIX'} = '-d=';
   $project{'INCLUDE_PREFIX'} = '-i=';
   ComputeConfigDependencies();
   $linebreak = '&';
   StdInit();
   ComputeWin32TargetVersions();
#! Compute TMAKE_LNK_CMD, TMAKE_LINK_CMD, TMAKE_MAKE_HEADER:
   $project{'TMAKE_LIB_CMD'}   = '@%create $(TMPLIST)'."\n\t"; 
   $project{'TMAKE_LIB_CMD'}  .= '@for %i in ( $(OBJECTS) $(OBJMOC) ) do @%append $(TMPLIST) +\'%i\''."\n\t";
   $project{'TMAKE_LIB_CMD'}  .= '$(LIB) $(TARGET) @$(TMPLIST)'."\n\t";
   $project{'TMAKE_LIB_CMD'}  .= 'del $(TMPLIST)';
   $project{'TMAKE_LINK_CMD'}  = '@%create $(TMPLIST)'."\n\t"; 
   $project{'TMAKE_LINK_CMD'} .= '@%append $(TMPLIST) NAME '.$project{'TARGET'}."\n\t";
   $project{'TMAKE_LINK_CMD'} .= '@%append $(TMPLIST) FIL ' .  join(",",split(/\s+/,$project{'OBJECTS'}))."\n\t";
   $project{'TMAKE_LINK_CMD'} .= '@%append $(TMPLIST) LIBR ' . join(",",split(/\s+/,$project{'TMAKE_LIBS'}))."\n\t";
   $project{'TMAKE_LINK_CMD'} .= '$(LINK) $(LFLAGS) @$(TMPLIST)'."\n\t";
   $project{'TMAKE_LINK_CMD'} .= 'del $(TMPLIST)';
   $project{'TMAKE_MAKE_HEADER'}  = "TMPLIST =\t".$project{'TARGET_LST'};
#$}
#$ IncludeTemplate("../win32/generic.t");
