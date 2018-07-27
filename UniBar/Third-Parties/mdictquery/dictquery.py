import sys
import json
from mdict_query import IndexBuilder


#if sys.argv.__len__() < 3:
#    sys.exit(1)

#print sys.argv

dict = {}

query_type = sys.argv[2]
query_word = sys.argv[3].strip()

builder = IndexBuilder('/Users/david/Desktop/lw.mdx')

if query_type == "key":
    dict[query_word] = builder.mdx_lookup(query_word, True)
elif query_type == "wildcard":
    keys = builder.get_mdx_keys(query_word)
    count = 0
    for key in keys:
        count += 1
        dict[key] = builder.mdx_lookup(key)
        if count > 10:
            break
elif query_type == "wildcardcount":
    keys = builder.get_mdx_keys(query_word)
    print keys.__len__()
    sys.exit(0)


print json.dumps(dict)
#result_text = builder.mdx_lookup('dedication')
#print result_text
