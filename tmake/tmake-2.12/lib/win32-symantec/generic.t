#!
#! This is a tmake template for building win32-symantic applications.
#!
#${
   $project{'OBJ_IMPL_OUT'} = '-o$@ $<';
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
#! Compute TMAKE_BLD_CMD, TMAKE_MAKE_HEADER:
   $project{'TMAKE_LIB_CMD'}  = '$(LIB) $(TARGET) '; 
   $project{'TMAKE_LIB_CMD'} .= join(" \\\n+",split(/\s+/,$project{'OBJECTS'})) . " \\\n+";
   $project{'TMAKE_LIB_CMD'} .= ',;';
   $project{'TMAKE_LINK_CMD'} = '$(LINK) $(LFLAGS) $(OBJECTS) $(OBJMOC), $(TARGET),, $(LIBS)';
#$}
#$ IncludeTemplate("../win32/generic.t");
