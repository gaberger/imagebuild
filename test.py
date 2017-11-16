from pykickstart.parser import *
from pykickstart.version import makeVersion
ksparser = KickstartParser(makeVersion())
ksparser.readKickstart("ks.cfg")
