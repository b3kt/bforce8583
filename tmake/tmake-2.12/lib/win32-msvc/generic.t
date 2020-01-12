#!
#! This is a tmake template for building win32-msvc applications.
#!
#$ $project{'OBJ_IMPL_OUT'}   = '-Fo$@ $<';
#$ $project{'TMAKE_LINK_CMD'} = '$(LINK) $(LFLAGS) /OUT:$(TARGET) @<<'."\n\t".'    $(OBJECTS) $(OBJMOC) $(LIBS)'."\n".'<<';
#$ $project{'TMAKE_LIB_CMD'}  = '$(LIB) /OUT:$(TARGET) @<<'."\n\t".'    $(OBJECTS) $(OBJMOC)'."\n".'<<';
#${
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
   $project{'TMAKE_REMOVE'} = '-del';
   $project{'TMAKE_RMDIR'} = '-rmdir /q /s';
   $project{'TMAKE_LIB_CMD'} ||
      ($project{'TMAKE_LIB_CMD'} = $project{'TMAKE_LINK_CMD'});
   Project('debug:TMAKE_LFLAGS += /PDB:$$_TARGET.pdb');
   Project('debug:TMAKE_CLEAN += vc*.pdb $$_TARGET.ilk $$_TARGET.pdb' );
   Project('TMAKE_CLEAN += $$_TARGET.opt' );
   Project('CLEAN_DIRS += Debug Release' );
   Project('TMAKE_DIST_FILES += *.dsp *.dsw *.opt *.ncb *.mak' );
   Project('dll:TMAKE_CLEAN += $$_TARGET.lib $$_TARGET.exp');
   if (Project("TMAKE_LIB_FLAG"))
      {Project('TMAKE_LFLAGS += /implib:$$_TARGET.lib');}
#$}
#$ IncludeTemplate("../win32/generic.t");
