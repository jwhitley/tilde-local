def csvToList(s):
    """Converts a string of comma-separated values into a list,
stripping all spaces.
>>> s = csvToList('foo,bar,baz')
>>> s == ['foo','bar','baz']
True
>>> s = csvToList('   this  , has,spaces  ')
>>> s == ['this','has','spaces']
True
"""
    return [x.strip(' ') for x in s.split(',')]

def csvToSet(s):
    """Converts a string of comma-separated values into a set, 
stripping all spaces.

>>> s = csvToSet('foo,bar,baz')
>>> s == set(['foo','bar','baz'])
True
>>> s = csvToSet('   this  , has,spaces  ')
>>> s == set(['has','spaces','this'])
True
"""
    return set(csvToList(s))
