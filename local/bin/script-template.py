#!/usr/bin/env python
import os
import optparse
import re
import sys

def _test(verbose):
    """Run doctests on this module"""
    import doctest
    doctest.testmod(verbose=verbose)

def _main(options,args):
    """Put the script code here."""
    pass

if __name__ == "__main__":
    usage = """usage: %prog [options]

%prog is a stock template for writing python scripts."""

    def list_callback(option, opt, value, parser):
        """optparse callback which accepts and appends a list of comma-separated values.

        For example: myprog --colors red,green,blue
        """
        if getattr(parser.values, option.dest):
            getattr(parser.values, option.dest).extend(value.split)
        setattr(parser.values, option.dest, value.split(','))

    parser = optparse.OptionParser(usage=usage)
    parser.add_option("--debug",action="store_true",dest="debug",help="Run under the PDB debugger.",default=False)
    parser.add_option("--test", dest="test", action="store_true", help=parser.expand_prog_name("Run doctests for %prog"), default=False)
    parser.add_option("--verbose", "-v", dest="verbose", action="store_true", help="Verbose doctests; only applies with --test", default=False)
    # Example for list_callback
    #
    # parser.add_option("--targets=TARGETS", "-t", dest="targets", action="callback", callback=list_callback, type="string", help="Comma-separated list of targets", default=[])
    (options,args) = parser.parse_args()

    if options.test:
        _test(options.verbose)
        sys.exit(0)

    if options.debug:
        import pdb
        pdb.run("_main(options,args)")
    else:
        _main(options,args)
