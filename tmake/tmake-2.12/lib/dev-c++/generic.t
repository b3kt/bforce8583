#!
#! This is a tmake template for building Win32 Dev-C++ project files for applications or libraries.
#!
#${
    if (Config("qt_dll")) {Project('CONFIG += qt');}
    if ( !Project("INTERFACE_DECL_PATH") ) {
	Project('INTERFACE_DECL_PATH = .' );
    }
    if ( Config("qt") ) {
	if ( !(Project("DEFINES") =~ /QT_NODLL/) &&
	     ((Project("DEFINES") =~ /QT_(?:MAKE)?DLL/) || Config("qt_dll") ||
	      ($ENV{"QT_DLL"} && !$ENV{"QT_NODLL"})) ) {
	    Project('TMAKE_QT_DLL = 1');
	    if ( (Project("TARGET") eq "qt") && Project("TMAKE_LIB_FLAG") ) {
		Project('CONFIG += dll');
	    }
	}
    }
    if ( Config("dll") || Project("TMAKE_APP_FLAG") ) {
	Project('CONFIG -= staticlib');
	Project('TMAKE_APP_OR_DLL = 1');
      if ( Config("dll") ) 
         {
         Project('DEV_CPP_TYPE = 3');
         Project('DEFINES += DBUILDING_DLL=1');
         }
      else {
      if ( Config("console") ) {Project('DEV_CPP_TYPE = 1');}
      else {Project('DEV_CPP_TYPE = 0');} }
    } else {
	Project('CONFIG += staticlib');
	Project('DEV_CPP_TYPE = 2');
    }
    if ( Config("warn_off") ) {
	Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_WARN_OFF');
	Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_WARN_OFF');
    } elsif ( Config("warn_on") ) {
	Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_WARN_ON');
	Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_WARN_ON');
    }
    if ( Config("debug") ) {
        if ( Config("thread") ) {
	    if ( Config("dll") ) {
	        Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_MT_DLLDBG');
	        Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_MT_DLLDBG');
 	    } else {
		Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_MT_DBG');
		Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_MT_DBG');
	    }
        }
        Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_DEBUG');
        Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_DEBUG');
        Project('TMAKE_LFLAGS += $$TMAKE_LFLAGS_DEBUG');
        Project('DEFINES += _DEBUG');
        Project('OBJECTS_DIR += debug');
    } elsif ( Config("release") ) {
	if ( Config("thread") ) {
	    if ( Config("dll") ) {
		Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_MT_DLL');
		Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_MT_DLL');
	    } else {
		Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_MT');
		Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_MT');
	    }
	}
	Project('TMAKE_CFLAGS += $$TMAKE_CFLAGS_RELEASE');
	Project('TMAKE_CXXFLAGS += $$TMAKE_CXXFLAGS_RELEASE');
      Project('OBJECTS_DIR += release');
    }

    Project('TMAKE_LIBS += $$LIBS');

    if ( Project("TMAKE_INCDIR") ) {
	AddIncludePath(Project("TMAKE_INCDIR"));
    }
    if ( Config("qt") || Config("opengl") ) {
	Project('CONFIG += windows' );
    }
    if ( Config("qt") ) {
	Project('CONFIG *= moc');
	AddIncludePath(Project("TMAKE_INCDIR_QT"));
	if ( !Config("debug") ) {
	    Project('DEFINES += NO_DEBUG');
	}
	if ( (Project("TARGET") eq "qt") && Project("TMAKE_LIB_FLAG") ) {
	    if ( Project("TMAKE_QT_DLL") ) {
		Project('DEFINES *= QT_MAKEDLL');
		Project('TMAKE_LFLAGS += $$TMAKE_LFLAGS_QT_DLL');
	    }
	} else {
	    Project('TMAKE_LIBS *= $$TMAKE_LIBS_QT');
	    if ( Project("TMAKE_QT_DLL") ) {
		my $qtver =FindHighestLibVersion($ENV{"QTDIR"} . "/lib", "qt");
		Project("TMAKE_LIBS /= s/qt.lib/qt${qtver}.lib/");
		if ( !Config("dll") ) {
		    Project('TMAKE_LIBS *= $$TMAKE_LIBS_QT_DLL');
		}
	    }
	}
    }
    if ( Config("opengl") ) {
	Project('TMAKE_LIBS *= $$TMAKE_LIBS_OPENGL');
    }
    if ( Config("dll") ) {
	Project('TMAKE_LFLAGS_CONSOLE_ANY = $$TMAKE_LFLAGS_CONSOLE_DLL');
	Project('TMAKE_LFLAGS_WINDOWS_ANY = $$TMAKE_LFLAGS_WINDOWS_DLL');
	if ( Project("TMAKE_LIB_FLAG") ) {
	    my $ver = Project("VERSION");
	    $ver =~ s/\.//g;
	    $project{"TARGET_EXT"} = "${ver}.dll";
	} else {
	    $project{"TARGET_EXT"} = ".dll";
	}
    } else {
	Project('TMAKE_LFLAGS_CONSOLE_ANY = $$TMAKE_LFLAGS_CONSOLE');
	Project('TMAKE_LFLAGS_WINDOWS_ANY = $$TMAKE_LFLAGS_WINDOWS');
	if ( Project("TMAKE_APP_FLAG") ) {
	    $project{"TARGET_EXT"} = ".exe";
	} else {
	    $project{"TARGET_EXT"} = ".lib";
	}
    }
    if ( Config("windows") ) {
	if ( Config("console") ) {
	    Project('TMAKE_LFLAGS *= $$TMAKE_LFLAGS_CONSOLE_ANY');
	    Project('TMAKE_LIBS   *= $$TMAKE_LIBS_CONSOLE');
	} else {
	    Project('TMAKE_LFLAGS *= $$TMAKE_LFLAGS_WINDOWS_ANY');
	}
	Project('TMAKE_LIBS   *= $$TMAKE_LIBS_WINDOWS');
    } else {
	Project('TMAKE_LFLAGS *= $$TMAKE_LFLAGS_CONSOLE_ANY');
	Project('TMAKE_LIBS   *= $$TMAKE_LIBS_CONSOLE');
    }
    if ( Config("moc") ) {
	$moc_aware = 1;
    }
    if ( Config("no_cpp") ) 
      {Project('TMAKE_USING_CPP = 0');}
    else
      {Project('TMAKE_USING_CPP = 1');}
    Project('TMAKE_FILETAGS = HEADERS SOURCES DEF_FILE RC_FILE TARGET TMAKE_LIBS DESTDIR DLLDESTDIR $$FILETAGS');
    foreach ( split(/\s/,Project("TMAKE_FILETAGS")) ) {
	$project{$_} =~ s-[/\\]+-\\-g;
    }
    if ( Project("DEF_FILE") ) {
	Project('TMAKE_LFLAGS *= /DEF:$$DEF_FILE');
    }
    if ( Project("RC_FILE") ) {
	if ( Project("RES_FILE") ) {
	    tmake_error("Both .rc and .res file specified.\n" .
			"Please specify one of them, not both.");
	}
	$project{"RES_FILE"} = $project{"RC_FILE"};
	$project{"RES_FILE"} =~ s/\.rc$/.res/i;
	Project('TARGETDEPS += $$RES_FILE');
    }
    if ( Project("RES_FILE") ) {
	Project('TMAKE_LIBS *= $$RES_FILE');
    }
    StdInit();
    if ( Project("VERSION") ) {
	$project{"VER_MAJ"} = $project{"VERSION"};
	$project{"VER_MAJ"} =~ s/\.\d+$//;
	$project{"VER_MIN"} = $project{"VERSION"};
	$project{"VER_MIN"} =~ s/^\d+\.//;
    }
    Project('dll:TMAKE_CLEAN += $$DESTDIR$$TARGET.lib');
    $project{"ALL_FILES"} = $project{"HEADERS"} . " " . $project{"SOURCES"};
    $project{"UNIT_COUNT"} = 0;
    foreach ( split (/\s/, $project{"ALL_FILES"}) ) 
       {
       $project{"FILES_LIST_ORDER"} .= $project{"UNIT_COUNT"};
       $project{"UNIT_COUNT"} += 1; 
       $project{"ALL_FILES_LIST"} .= "[Unit" . $project{"UNIT_COUNT"} . "]\n";
       $project{"ALL_FILES_LIST"} .= "FileName=" . $_ . "\n";
       $project{"ALL_FILES_LIST"} .= "Open=1\n";
       $project{"ALL_FILES_LIST"} .= "Top=0\n";
       $project{"ALL_FILES_LIST"} .= "CursorCol=1\n";
       $project{"ALL_FILES_LIST"} .= "CursorRow=1\n";
       $project{"ALL_FILES_LIST"} .= "\n";
       $project{"FILES_LIST_ORDER"} .= "\n";
       }
#$}
[Project]
FileName=#$ ExpandGlue("TARGET","","",".dev");
Name=#$ Expand("TARGET");
UnitCount=#$ Expand("UNIT_COUNT");
Type=#$ Expand("DEV_CPP_TYPE");
Ver=1
ObjFiles=
Includes=#$ ExpandPath("INCPATH","",";","");
Libs=
PrivateResource=
ResourceIncludes=
Resources=
Compiler=#$ Expand("TMAKE_CXXFLAGS"); ExpandGlue("DEFINES","-D"," -D","");
Linker=#$ Expand("TMAKE_LFLAGS"); ExpandGlue("TMAKE_LIBS",""," ","");
IsCpp=#$ Expand("TMAKE_USING_CPP");
Icon=
ExeOutput=#$ Expand("DESTDIR");
ObjectOutput=
Focused=0
Order=#$ ExpandGlue("FILES_LIST_ORDER", "", ",", "");

#$ Expand("ALL_FILES_LIST");
[Views]
ProjectView=1

