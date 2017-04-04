From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 00/33]  Convert input documentation to ReST
Date: Tue,  4 Apr 2017 07:52:10 -0300
Message-ID: <cover.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, Peter Hutterer <peter.hutterer@who-t.net>, Markus Heiser <markus.heiser@darmarit.de>, Henk Vergonet <Henk.Vergonet@gmail.com>, usbb2k-api-dev@nongnu.org, Martin Kepplinger <martink@posteo.de>, Ben Gamari <ben@smart-cactus.org>
List-Id: linux-input@vger.kernel.org

As I'm needing to touch some Input documentation, I took the time
to also convert the existing documents to ReST markup, building them
with Sphinx. The end result can be seen at:

   http://www.infradead.org/~mchehab/kernel_docs/input/

Instead of placing the documentation under Documentation/driver-api, I opted
to keep them at Documentation/input. The rationale is that the documentation
there doesn't have only driver-api bits, but other things too.

Those patches are based on the linux-input tree, on its next branch:
   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

Please notice that I converted the two existing XFIG files there to SVG. As the
Documentation/sphinx/kfigure.py doesn't exist at the input tree, I opted
to use the ".. figure" tag to include the SVG files. This should be changed to
use the right extension, after merging upstream, but this should be a two line
patch that can be applied afterwards.

PS.: I didn't try to update the contents of the documentation int his series.

v2:
   - Rebased on current upstream, fixing a conflict at input.txt;
   - Added Peter Hutterer ack to event-codes.txt

Mauro Carvalho Chehab (33):
  docs: Documentation/input/input: convert it to ReST format
  docs: input/alps: convert it to ReST format
  docs: input/amijoy: convert it to ReST format
  docs: input/appletouch: convert it to ReST format
  docs: input/atarikbd: convert it to ReST format
  docs: input/bcm5974: convert it to ReST format
  docs: input/cd32: convert it to ReST format
  docs: input/cma3000_d0x: convert it to ReST format
  docs: input/cs461x: convert it to ReST format
  docs: input/elantech: convert it to ReST format
  docs: input/event-codes: convert it to ReST format
  docs: input/ff: convert it to ReST format
  docs: input/gamepad: convert it to ReST format
  docs: input/gameport-programming: convert it to ReST format
  docs: input/gpio-tilt: convert it to ReST format
  docs: input/iforce-protocol: convert it to ReST format
  docs: input/input-programming: convert it to ReST format
  docs: input/joystick-api: convert it to ReST format
  docs: input/joystick: convert it to ReST format
  docs: input/joystick-parport: convert it to ReST format
  docs: input/multi-touch-protocol: convert it to ReST format
  docs: input/notifier: convert it to ReST format
  docs: input/ntrig: convert it to ReST format
  docs: input/rotary-encoder: convert it to ReST format
  docs: input/sentelic: convert it to ReST format
  docs: input/userio: convert it to ReST format
  docs: input/walkera0701: convert it to ReST format
  docs: input/xpad: convert it to ReST format
  docs: input/yealink: convert it to ReST format
  docs-rst: create a book with Linux Input documentation
  docs: input/shape: convert it from xfig to svg
  docs: input/interactive: convert from xfig to svg
  docs: ff.rst: use svg files instead of xfig

 Documentation/conf.py                              |   2 +
 Documentation/input/{alps.txt => alps.rst}         |  43 +-
 Documentation/input/{amijoy.txt => amijoy.rst}     | 165 ++--
 .../input/{appletouch.txt => appletouch.rst}       |  33 +-
 Documentation/input/{atarikbd.txt => atarikbd.rst} | 214 +++--
 Documentation/input/{bcm5974.txt => bcm5974.rst}   |  43 +-
 Documentation/input/cd32.rst                       |  23 +
 Documentation/input/cd32.txt                       |  19 -
 .../input/{cma3000_d0x.txt => cma3000_d0x.rst}     |  72 +-
 Documentation/input/conf.py                        |  10 +
 Documentation/input/{cs461x.txt => cs461x.rst}     |  28 +-
 .../input/{edt-ft5x06.txt => edt-ft5x06.rst}       |   0
 Documentation/input/{elantech.txt => elantech.rst} | 306 +++----
 .../input/{event-codes.txt => event-codes.rst}     | 132 ++-
 Documentation/input/{ff.txt => ff.rst}             | 205 +++--
 Documentation/input/{gamepad.txt => gamepad.rst}   |  43 +-
 ...rt-programming.txt => gameport-programming.rst} |  83 +-
 Documentation/input/gpio-tilt.rst                  | 103 +++
 Documentation/input/gpio-tilt.txt                  | 103 ---
 Documentation/input/iforce-protocol.rst            | 381 +++++++++
 Documentation/input/iforce-protocol.txt            | 258 ------
 Documentation/input/index.rst                      |  77 ++
 ...input-programming.txt => input-programming.rst} | 253 +++---
 Documentation/input/{input.txt => input.rst}       | 238 +++---
 Documentation/input/interactive.fig                |  42 -
 Documentation/input/interactive.svg                |  24 +
 .../input/{joystick-api.txt => joystick-api.rst}   | 138 ++--
 Documentation/input/joystick-parport.rst           | 574 +++++++++++++
 Documentation/input/joystick-parport.txt           | 542 -------------
 Documentation/input/{joystick.txt => joystick.rst} | 541 +++++++------
 ...touch-protocol.txt => multi-touch-protocol.rst} | 196 +++--
 Documentation/input/{notifier.txt => notifier.rst} |  10 +-
 Documentation/input/{ntrig.txt => ntrig.rst}       |  49 +-
 .../{rotary-encoder.txt => rotary-encoder.rst}     |  74 +-
 Documentation/input/sentelic.rst                   | 901 +++++++++++++++++++++
 Documentation/input/sentelic.txt                   | 873 --------------------
 Documentation/input/shape.fig                      |  65 --
 Documentation/input/shape.svg                      |  39 +
 Documentation/input/{userio.txt => userio.rst}     |  79 +-
 .../input/{walkera0701.txt => walkera0701.rst}     |  53 +-
 Documentation/input/{xpad.txt => xpad.rst}         | 120 +--
 Documentation/input/{yealink.txt => yealink.rst}   | 164 ++--
 42 files changed, 4046 insertions(+), 3272 deletions(-)
 rename Documentation/input/{alps.txt => alps.rst} (95%)
 rename Documentation/input/{amijoy.txt => amijoy.rst} (63%)
 rename Documentation/input/{appletouch.txt => appletouch.rst} (81%)
 rename Documentation/input/{atarikbd.txt => atarikbd.rst} (91%)
 rename Documentation/input/{bcm5974.txt => bcm5974.rst} (55%)
 create mode 100644 Documentation/input/cd32.rst
 delete mode 100644 Documentation/input/cd32.txt
 rename Documentation/input/{cma3000_d0x.txt => cma3000_d0x.rst} (67%)
 create mode 100644 Documentation/input/conf.py
 rename Documentation/input/{cs461x.txt => cs461x.rst} (87%)
 rename Documentation/input/{edt-ft5x06.txt => edt-ft5x06.rst} (100%)
 rename Documentation/input/{elantech.txt => elantech.rst} (88%)
 rename Documentation/input/{event-codes.txt => event-codes.rst} (96%)
 rename Documentation/input/{ff.txt => ff.rst} (62%)
 rename Documentation/input/{gamepad.txt => gamepad.rst} (91%)
 rename Documentation/input/{gameport-programming.txt => gameport-programming.rst} (85%)
 create mode 100644 Documentation/input/gpio-tilt.rst
 delete mode 100644 Documentation/input/gpio-tilt.txt
 create mode 100644 Documentation/input/iforce-protocol.rst
 delete mode 100644 Documentation/input/iforce-protocol.txt
 create mode 100644 Documentation/input/index.rst
 rename Documentation/input/{input-programming.txt => input-programming.rst} (69%)
 rename Documentation/input/{input.txt => input.rst} (55%)
 delete mode 100644 Documentation/input/interactive.fig
 create mode 100644 Documentation/input/interactive.svg
 rename Documentation/input/{joystick-api.txt => joystick-api.rst} (79%)
 create mode 100644 Documentation/input/joystick-parport.rst
 delete mode 100644 Documentation/input/joystick-parport.txt
 rename Documentation/input/{joystick.txt => joystick.rst} (50%)
 rename Documentation/input/{multi-touch-protocol.txt => multi-touch-protocol.rst} (68%)
 rename Documentation/input/{notifier.txt => notifier.rst} (90%)
 rename Documentation/input/{ntrig.txt => ntrig.rst} (75%)
 rename Documentation/input/{rotary-encoder.txt => rotary-encoder.rst} (75%)
 create mode 100644 Documentation/input/sentelic.rst
 delete mode 100644 Documentation/input/sentelic.txt
 delete mode 100644 Documentation/input/shape.fig
 create mode 100644 Documentation/input/shape.svg
 rename Documentation/input/{userio.txt => userio.rst} (56%)
 rename Documentation/input/{walkera0701.txt => walkera0701.rst} (86%)
 rename Documentation/input/{xpad.txt => xpad.rst} (81%)
 rename Documentation/input/{yealink.txt => yealink.rst} (63%)

-- 
2.9.3


