#!
#! This is a tmake template for building Unix kdevelop project files for applications or libraries.
#!
#${
    $project{'TMAKE_OUTEXT'} = ".kdevprj"; 
    $project{"ALL_FILES"} = $project{"TARGET"} . ".kdevprj " . $project{"HEADERS"} . " " . $project{"SOURCES"};
    foreach ( split (/\s/, $project{"HEADERS"}) )
       {
       $project{"ALL_FILES_LIST"} .= "[" . $_ . "]\n";
       $project{"ALL_FILES_LIST"} .= "dist=true\n";
       $project{"ALL_FILES_LIST"} .= "isntall=false\n";
       $project{"ALL_FILES_LIST"} .= "install_location=\n";
       $project{"ALL_FILES_LIST"} .= "type=HEADER\n";
       $project{"ALL_FILES_LIST"} .= "\n";
       }
    foreach ( split (/\s/, $project{"SOURCES"}) )
       {
       $project{"ALL_FILES_LIST"} .= "[" . $_ . "]\n";
       $project{"ALL_FILES_LIST"} .= "dist=true\n";
       $project{"ALL_FILES_LIST"} .= "install=false\n";
       $project{"ALL_FILES_LIST"} .= "install_location=\n";
       $project{"ALL_FILES_LIST"} .= "type=SOURCE\n";
       $project{"ALL_FILES_LIST"} .= "\n";
       }
#$}
[Config for BinMakefileAm]
addcxxflags=
bin_program=#$ ExpandGlue("TARGET",$project{"DESTDIR"},"",$project{"TARGET_EXT"});
cflags=
cppflags=
cxxflags=\s-O0 -g3 -Wall
ldadd=
ldflags=\s\s

[General]
AMChanged=false
author=
configure_args=
email=
kdevprj_version=1.3
lfv_open_groups=
make_options=-j1
makefiles=Makefile
project_name=#$ Expand("TARGET");
project_type=normal_cpp
sub_dir=
version=0.1
version_control=None
workspace=1

[LFV Groups]
Headers=*.h,*.hh,*.hxx,*.hpp,*.H
Others=*
Sources=*.cpp,*.c,*.cc,*.C,*.cxx,*.ec,*.ecpp,*.lxx,*.l++,*.ll,*.l
groups=Headers,Sources,Others

[Makefile]
files=#$ ExpandGlue("ALL_FILES","",",","");
sub_dirs=
type=prog_main

[#$ ExpandGlue("TARGET","","",".kdevprj]");
dist=true
install=false
install_location=
type=DATA

#$ Expand("ALL_FILES_LIST");
