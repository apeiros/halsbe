/**********************************************************************

	taken from rubys main.c

  Author: Stefan Rusterholz

  Copyright (C) 1993-2003 Yukihiro Matsumoto

	gcc -I/opt/local/lib/ruby/1.8/powerpc-darwin9.0.0 -L/opt/local/lib -lruby -o halsbe halsbe.c

**********************************************************************/

#include "ruby.h"

#if defined __MINGW32__
	int _CRT_glob = 0;
#endif

int
main(argc, argv, envp)
	int argc;
	char **argv, **envp;
{
#ifdef _WIN32
	NtInitialize(&argc, &argv);
#endif
	{
		RUBY_INIT_STACK
		ruby_init();               // initialize ruby interpreter itself
		ruby_set_argv(argc, argv); // initializes ARGV
		ruby_init_loadpath();      // initializes $:
		rb_load_file("halsbe.rb"); // load halsbe.rb
		ruby_run();                // run the code
	}
	return 0;
}
