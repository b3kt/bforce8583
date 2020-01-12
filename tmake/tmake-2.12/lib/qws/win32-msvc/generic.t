#!
#! This is a tmake template for building win32-msvc applications.
#!
#${
   $project{'OBJ_IMPL_OUT'}   = '-Fo$@ $<';
   $project{'TMAKE_LINK_CMD'} = '$(LINK) $(LFLAGS) /OUT:$(TARGET) @<<'."\n\t".'    $(OBJECTS) $(OBJMOC) $(LIBS)'."\n".'<<';
   $project{'TMAKE_LIB_CMD'}  = '$(LIB) /OUT:$(TARGET) @<<'."\n\t".'    $(OBJECTS) $(OBJMOC)'."\n".'<<';
   ComputeConfigDependencies();
   StdInit();
   ComputeWin32TargetVersions();
   if ( Config ("qtopia") && (Project("TARGET") ne "qte") ) {
      if ( Config("debug") ) {
         Project("TMAKE_CXXFLAGS *= -MDd");
         Project("TMAKE_CFLAGS *= -MDd"); }
      else {
         Project("TMAKE_CXXFLAGS *= -MD");
         Project("TMAKE_CFLAGS *= -MD"); }}
   if ( ($project{"TARGET"} eq "qte") && Project("PRECOMPH") ) {
      $project{'TMAKE_MAKE_HEADER'}  = "allmoc.cpp: ".Project("PRECOMPH")." ".$original_HEADERS;
      $project{'TMAKE_MAKE_HEADER'} .= join(" ",split(/\s/,$project{'HEADERS_ORIG'})) . " ";
      $project{'TMAKE_MAKE_HEADER'} .= "\n\techo #include \"".Project("PRECOMPH")."\" >allmoc.cpp";
      $project{'TMAKE_MAKE_HEADER'} .= "\n\t\$(CXX) -E -C -DQT_MOC_CPP \$(CXXFLAGS) \$(INCPATH) allmoc.cpp >allmoc.h";
      $project{'TMAKE_MAKE_HEADER'} .= "\n\t\$(MOC) -o allmoc.cpp allmoc.h";
      $project{'TMAKE_MAKE_HEADER'} .= "\n\tperl -p -i.bak -e \"s!allmoc.h!".Project("PRECOMPH")."!\" allmoc.cpp";
      $project{'TMAKE_MAKE_HEADER'} .= "\n\tdel allmoc.h";
      $project{'TMAKE_MAKE_HEADER'} .= "\n"; }
#$}
#$ IncludeTemplate("../../make/generic.t");
