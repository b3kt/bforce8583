#!
#! This is a tmake template for building win32-g++ applications.
#!
#${
   check_unix(1);
   $project{'OBJ_IMPL_OUT'}   = '-o $@ $<';
   $project{'CLEAN_FILES'}    = 'core *~';
   $project{'TMAKE_REMOVE'}   = 'rm -f';
   $project{'TMAKE_LINK_CMD'} = '$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJMOC) $(LIBS)';
   $project{'TMAKE_LIB_CMD'}  = '$(AR) $(TARGET) $(OBJECTS) $(OBJMOC)';
   $project{'INCLUDE_QUOTE'}  = '"';
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
   if ( Config('dll') ) {
      my $win32_lib_exists = `lib.exe 2>&1`;
      if ( $win32_lib_exists =~ /Microsoft \(R\) Library Manager/ ) {
         my $t_ = "$project{'_TARGET'}";
         $project{'CLEAN_FILES'}    .= " $t_.def $t_.exp $t_.lib";
         $project{'TMAKE_LFLAGS'}   .= " -Wl,--output-def,$t_.def.strip";
         $project{'TMAKE_LINK_CMD'} .= "\n\tperl -n -e '!/^IMPORTS/ && print || exit;' < $t_.def.strip > $t_.def ; rm -f $t_.def.strip";
         $project{'TMAKE_LINK_CMD'} .= "\n\tlib.exe /nologo /machine:ix86 /def:$project{'_TARGET'}.def /out:$project{'_TARGET'}.lib"; } }
   ComputeCompilerFlags();
#$}
#$ IncludeTemplate("../$project{'OUTTYPE'}/$project{'TEMPLATE'}.t");
