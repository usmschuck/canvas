from unittest import TestCase

import simplejson as json
import textwrap
from StringIO import StringIO

class TestIndent(TestCase):
    def test_indent(self):
        h = [['blorpie'], ['whoops'], [], 'd-shtaeou', 'd-nthiouh',
             'i-vhbjkhnth',
             {'nifty': 87}, {'field': 'yes', 'morefield': False} ]

        expect = textwrap.dedent("""\
        [
        \t[
        \t\t"blorpie"
        \t],
        \t[
        \t\t"whoops"
        \t],
        \t[],
        \t"d-shtaeou",
        \t"d-nthiouh",
        \t"i-vhbjkhnth",
        \t{
        \t\t"nifty": 87
        \t},
        \t{
        \t\t"field": "yes",
        \t\t"morefield": false
        \t}
        ]""")


        d1 = json.dumps(h)
        d2 = json.dumps(h, indent='\t', sort_keys=True, separators=(',', ': '))
        d3 = json.dumps(h, indent='  ', sort_keys=True, separators=(',', ': '))
        d4 = json.dumps(h, indent=2, sort_keys=True, separators=(',', ': '))

        h1 = json.loads(d1)
        h2 = json.loads(d2)
        h3 = json.loads(d3)
        h4 = json.loads(d4)

        self.assertEquals(h1, h)
        self.assertEquals(h2, h)
        self.assertEquals(h3, h)
        self.assertEquals(h4, h)
        self.assertEquals(d3, expect.replace('\t', '  '))
        self.assertEquals(d4, expect.replace('\t', '  '))
        # NOTE: Python 2.4 textwrap.dedent converts tabs to spaces,
        #       so the following is expected to fail. Python 2.4 is not a
        #       supported platform in simplejson 2.1.0+.
        self.assertEquals(d2, expect)

    def test_indent0(self):
        h = {3: 1}
        def check(indent, expected):
            d1 = json.dumps(h, indent=indent)
            self.assertEquals(d1, expected)

            sio = StringIO()
            json.dump(h, sio, indent=indent)
            self.assertEquals(sio.getvalue(), expected)

        # indent=0 should emit newlines
        check(0, '{\n"3": 1\n}')
        # indent=None is more compact
        check(None, '{"3": 1}')

    def test_separators(self):
        lst = [1,2,3,4]
        expect = '[\n1,\n2,\n3,\n4\n]'
        expect_spaces = '[\n1, \n2, \n3, \n4\n]'
        # Ensure that separators still works
        self.assertEquals(
            expect_spaces,
            json.dumps(lst, indent=0, separators=(', ', ': ')))
        # Force the new defaults
        self.assertEquals(
            expect,
            json.dumps(lst, indent=0, separators=(',', ': ')))
        # Added in 2.1.4
        self.assertEquals(
            expect,
            json.dumps(lst, indent=0))