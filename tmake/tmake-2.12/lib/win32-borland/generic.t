#!
#! This is a tmake template for building win32-msvc applications.
#!
#${
   $project{'OBJ_IMPL_OUT'} = '-o$@ $<';
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
#! Compute TMAKE_BLD_CMD, TMAKE_MAKE_HEADER:
   $project{'TMAKE_LIB_CMD'}  = '$(LIB) $(TARGET) @&&|'."\n"; 
   $project{'TMAKE_LIB_CMD'} .= '+' . join(" \\\n+",split(/\s+/,$project{'OBJECTS'})) . " \\\n+";
   $project{'TMAKE_LIB_CMD'} .= "\n".'|';
   $project{'TMAKE_LINK_CMD'} = '$(LINK) @&&|'."\n\t".'    $(LFLAGS) $(OBJECTS) $(OBJMOC),$(TARGET),,$(LIBS),$(DEF_FILE),$(RES_FILE)'."\n".'|';
   $project{'TMAKE_MAKE_HEADER'}  = "\n".'!if !$d(BCB)'."\n".'BCB = $(MAKEDIR)\\..'."\n".'!endif';
#$}
#$ IncludeTemplate("../win32/generic.t");
