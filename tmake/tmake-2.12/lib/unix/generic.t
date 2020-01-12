#!
#! This is a tmake template for building unix applications.
#!
#${
   $project{'OBJ_IMPL_OUT'}   = '-o $@ $<';
   $project{'CLEAN_FILES'}    = 'core *~';
   $project{'TMAKE_REMOVE'}   = 'rm -f';
   $project{'TMAKE_LINK_CMD'} = '$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJMOC) $(LIBS)';
   $project{'TMAKE_LIB_CMD'}  = '$(AR) $(TARGET) $(OBJECTS) $(OBJMOC)';
   $project{'TMAKE_LIBA_CMD'}  = '$(AR) $(TARGETA) $(OBJECTS) $(OBJMOC)';
   if ( $project{'TMAKE_RANLIB'} ) {
      $project{'TMAKE_LIB_CMD'}  .= "\n\t".'$(RANLIB) $(TARGET)';
      $project{'TMAKE_LIBA_CMD'}  .= "\n\t".'$(RANLIB) $(TARGETA)'; }
   $project{'TMAKE_RUN_CXX_IMP'}  = '1';
   ComputeConfigDependencies();
   StdInit();
   ComputeUnixTargetVersions();
   $project{'TMAKE_LIBS'}  = '$(SUBLIBS) '.$project{'TMAKE_LIBS'}; 
   $project{'TMAKE_DIST_FILES'} .= " *.kdevprj *.kdevses"; 
#$}
#$ IncludeTemplate("../$project{'OUTTYPE'}/$project{'TEMPLATE'}.t");
