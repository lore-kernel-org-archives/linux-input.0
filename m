From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 30/33] docs-rst: create a book with Linux Input documentation
Date: Tue,  4 Apr 2017 07:52:40 -0300
Message-ID: <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491302719.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491302719.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491302719.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491302719.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491302719.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491302719.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491302719.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491302719.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491302719.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491302719.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491302719.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491302719.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491302719.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491302719.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491302719.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491302719.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491302719.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491302719.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491302719.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491302719.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491302719.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491302719.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491302719.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491302719.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491302719.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491302719.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491302719.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <55d263f13237495276213de295ae1c6d67f0588b.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Markus Heiser <markus.heiser@darmarit.de>, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

Now that all files under Documentation/input follows the
ReST markup language, rename them to *.rst and create a
book for the Linux Input subsystem.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/conf.py                              |  2 +
 Documentation/input/{alps.txt => alps.rst}         |  0
 Documentation/input/{amijoy.txt => amijoy.rst}     |  0
 .../input/{appletouch.txt => appletouch.rst}       |  0
 Documentation/input/{atarikbd.txt => atarikbd.rst} |  0
 Documentation/input/{bcm5974.txt => bcm5974.rst}   |  0
 Documentation/input/{cd32.txt => cd32.rst}         |  0
 .../input/{cma3000_d0x.txt => cma3000_d0x.rst}     |  0
 Documentation/input/conf.py                        | 10 +++
 Documentation/input/{cs461x.txt => cs461x.rst}     |  0
 .../input/{edt-ft5x06.txt => edt-ft5x06.rst}       |  0
 Documentation/input/{elantech.txt => elantech.rst} |  0
 .../input/{event-codes.txt => event-codes.rst}     |  0
 Documentation/input/{ff.txt => ff.rst}             |  0
 Documentation/input/{gamepad.txt => gamepad.rst}   |  0
 ...rt-programming.txt => gameport-programming.rst} |  0
 .../input/{gpio-tilt.txt => gpio-tilt.rst}         |  0
 .../{iforce-protocol.txt => iforce-protocol.rst}   |  0
 Documentation/input/index.rst                      | 77 ++++++++++++++++++++++
 ...input-programming.txt => input-programming.rst} |  0
 Documentation/input/{input.txt => input.rst}       | 20 ------
 .../input/{joystick-api.txt => joystick-api.rst}   |  0
 .../{joystick-parport.txt => joystick-parport.rst} |  0
 Documentation/input/{joystick.txt => joystick.rst} |  0
 ...touch-protocol.txt => multi-touch-protocol.rst} |  0
 Documentation/input/{notifier.txt => notifier.rst} |  0
 Documentation/input/{ntrig.txt => ntrig.rst}       |  0
 .../{rotary-encoder.txt => rotary-encoder.rst}     |  0
 Documentation/input/{sentelic.txt => sentelic.rst} |  0
 Documentation/input/{userio.txt => userio.rst}     |  0
 .../input/{walkera0701.txt => walkera0701.rst}     |  0
 Documentation/input/{xpad.txt => xpad.rst}         |  0
 Documentation/input/{yealink.txt => yealink.rst}   |  0
 33 files changed, 89 insertions(+), 20 deletions(-)
 rename Documentation/input/{alps.txt => alps.rst} (100%)
 rename Documentation/input/{amijoy.txt => amijoy.rst} (100%)
 rename Documentation/input/{appletouch.txt => appletouch.rst} (100%)
 rename Documentation/input/{atarikbd.txt => atarikbd.rst} (100%)
 rename Documentation/input/{bcm5974.txt => bcm5974.rst} (100%)
 rename Documentation/input/{cd32.txt => cd32.rst} (100%)
 rename Documentation/input/{cma3000_d0x.txt => cma3000_d0x.rst} (100%)
 create mode 100644 Documentation/input/conf.py
 rename Documentation/input/{cs461x.txt => cs461x.rst} (100%)
 rename Documentation/input/{edt-ft5x06.txt => edt-ft5x06.rst} (100%)
 rename Documentation/input/{elantech.txt => elantech.rst} (100%)
 rename Documentation/input/{event-codes.txt => event-codes.rst} (100%)
 rename Documentation/input/{ff.txt => ff.rst} (100%)
 rename Documentation/input/{gamepad.txt => gamepad.rst} (100%)
 rename Documentation/input/{gameport-programming.txt => gameport-programming.rst} (100%)
 rename Documentation/input/{gpio-tilt.txt => gpio-tilt.rst} (100%)
 rename Documentation/input/{iforce-protocol.txt => iforce-protocol.rst} (100%)
 create mode 100644 Documentation/input/index.rst
 rename Documentation/input/{input-programming.txt => input-programming.rst} (100%)
 rename Documentation/input/{input.txt => input.rst} (92%)
 rename Documentation/input/{joystick-api.txt => joystick-api.rst} (100%)
 rename Documentation/input/{joystick-parport.txt => joystick-parport.rst} (100%)
 rename Documentation/input/{joystick.txt => joystick.rst} (100%)
 rename Documentation/input/{multi-touch-protocol.txt => multi-touch-protocol.rst} (100%)
 rename Documentation/input/{notifier.txt => notifier.rst} (100%)
 rename Documentation/input/{ntrig.txt => ntrig.rst} (100%)
 rename Documentation/input/{rotary-encoder.txt => rotary-encoder.rst} (100%)
 rename Documentation/input/{sentelic.txt => sentelic.rst} (100%)
 rename Documentation/input/{userio.txt => userio.rst} (100%)
 rename Documentation/input/{walkera0701.txt => walkera0701.rst} (100%)
 rename Documentation/input/{xpad.txt => xpad.rst} (100%)
 rename Documentation/input/{yealink.txt => yealink.rst} (100%)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7fadb3b83293..fef209edb4d7 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -348,6 +348,8 @@ latex_documents = [
      'The kernel development community', 'manual'),
     ('driver-api/index', 'driver-api.tex', 'The kernel driver API manual',
      'The kernel development community', 'manual'),
+    ('input/index', 'linux-input.tex', 'The Linux input driver subsystem',
+     'The kernel development community', 'manual'),
     ('kernel-documentation', 'kernel-documentation.tex', 'The Linux Kernel Documentation',
      'The kernel development community', 'manual'),
     ('process/index', 'development-process.tex', 'Linux Kernel Development Documentation',
diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.rst
similarity index 100%
rename from Documentation/input/alps.txt
rename to Documentation/input/alps.rst
diff --git a/Documentation/input/amijoy.txt b/Documentation/input/amijoy.rst
similarity index 100%
rename from Documentation/input/amijoy.txt
rename to Documentation/input/amijoy.rst
diff --git a/Documentation/input/appletouch.txt b/Documentation/input/appletouch.rst
similarity index 100%
rename from Documentation/input/appletouch.txt
rename to Documentation/input/appletouch.rst
diff --git a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.rst
similarity index 100%
rename from Documentation/input/atarikbd.txt
rename to Documentation/input/atarikbd.rst
diff --git a/Documentation/input/bcm5974.txt b/Documentation/input/bcm5974.rst
similarity index 100%
rename from Documentation/input/bcm5974.txt
rename to Documentation/input/bcm5974.rst
diff --git a/Documentation/input/cd32.txt b/Documentation/input/cd32.rst
similarity index 100%
rename from Documentation/input/cd32.txt
rename to Documentation/input/cd32.rst
diff --git a/Documentation/input/cma3000_d0x.txt b/Documentation/input/cma3000_d0x.rst
similarity index 100%
rename from Documentation/input/cma3000_d0x.txt
rename to Documentation/input/cma3000_d0x.rst
diff --git a/Documentation/input/conf.py b/Documentation/input/conf.py
new file mode 100644
index 000000000000..d2352fdc92ed
--- /dev/null
+++ b/Documentation/input/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "The Linux input driver subsystem"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'linux-input.tex', project,
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/input/cs461x.txt b/Documentation/input/cs461x.rst
similarity index 100%
rename from Documentation/input/cs461x.txt
rename to Documentation/input/cs461x.rst
diff --git a/Documentation/input/edt-ft5x06.txt b/Documentation/input/edt-ft5x06.rst
similarity index 100%
rename from Documentation/input/edt-ft5x06.txt
rename to Documentation/input/edt-ft5x06.rst
diff --git a/Documentation/input/elantech.txt b/Documentation/input/elantech.rst
similarity index 100%
rename from Documentation/input/elantech.txt
rename to Documentation/input/elantech.rst
diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.rst
similarity index 100%
rename from Documentation/input/event-codes.txt
rename to Documentation/input/event-codes.rst
diff --git a/Documentation/input/ff.txt b/Documentation/input/ff.rst
similarity index 100%
rename from Documentation/input/ff.txt
rename to Documentation/input/ff.rst
diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.rst
similarity index 100%
rename from Documentation/input/gamepad.txt
rename to Documentation/input/gamepad.rst
diff --git a/Documentation/input/gameport-programming.txt b/Documentation/input/gameport-programming.rst
similarity index 100%
rename from Documentation/input/gameport-programming.txt
rename to Documentation/input/gameport-programming.rst
diff --git a/Documentation/input/gpio-tilt.txt b/Documentation/input/gpio-tilt.rst
similarity index 100%
rename from Documentation/input/gpio-tilt.txt
rename to Documentation/input/gpio-tilt.rst
diff --git a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.rst
similarity index 100%
rename from Documentation/input/iforce-protocol.txt
rename to Documentation/input/iforce-protocol.rst
diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
new file mode 100644
index 000000000000..153f0d476c3e
--- /dev/null
+++ b/Documentation/input/index.rst
@@ -0,0 +1,77 @@
+=============================
+The Linux Input Documentation
+=============================
+
+Disclaimer
+==========
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along
+with this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+For your convenience, the GNU General Public License version 2 is included
+in the package: See the file COPYING.
+
+
+Core API
+========
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   input
+   input-programming
+   event-codes
+   joystick
+   joystick-api
+   multi-touch-protocol
+   gamepad
+   gameport-programming
+   ff
+   notifier
+   userio
+
+Input drivers
+=============
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   alps
+   amijoy
+   appletouch
+   atarikbd
+   bcm5974
+   cd32
+   cma3000_d0x
+   cs461x
+   edt-ft5x06
+   elantech
+   iforce-protocol
+   joystick-parport
+   gpio-tilt
+   ntrig
+   rotary-encoder
+   sentelic
+   walkera0701
+   xpad
+   yealink
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.rst
similarity index 100%
rename from Documentation/input/input-programming.txt
rename to Documentation/input/input-programming.rst
diff --git a/Documentation/input/input.txt b/Documentation/input/input.rst
similarity index 92%
rename from Documentation/input/input.txt
rename to Documentation/input/input.rst
index fda995e0ceb0..ac7669ad3e76 100644
--- a/Documentation/input/input.txt
+++ b/Documentation/input/input.rst
@@ -6,30 +6,10 @@ Linux Input drivers
 
 :Copyright: |copy| 1999-2001 Vojtech Pavlik <vojtech@ucw.cz> - Sponsored by SuSE
 
-Disclaimer
-==========
-
-This program is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the Free
-Software Foundation; either version 2 of the License, or (at your option)
-any later version.
-
-This program is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-more details.
-
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc., 59
-Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
 Should you need to contact me, the author, you can do so either by e-mail
 - mail your message to <vojtech@ucw.cz>, or by paper mail: Vojtech Pavlik,
 Simunkova 1594, Prague 8, 182 00 Czech Republic
 
-For your convenience, the GNU General Public License version 2 is included
-in the package: See the file COPYING.
-
 Introduction
 ============
 
diff --git a/Documentation/input/joystick-api.txt b/Documentation/input/joystick-api.rst
similarity index 100%
rename from Documentation/input/joystick-api.txt
rename to Documentation/input/joystick-api.rst
diff --git a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.rst
similarity index 100%
rename from Documentation/input/joystick-parport.txt
rename to Documentation/input/joystick-parport.rst
diff --git a/Documentation/input/joystick.txt b/Documentation/input/joystick.rst
similarity index 100%
rename from Documentation/input/joystick.txt
rename to Documentation/input/joystick.rst
diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.rst
similarity index 100%
rename from Documentation/input/multi-touch-protocol.txt
rename to Documentation/input/multi-touch-protocol.rst
diff --git a/Documentation/input/notifier.txt b/Documentation/input/notifier.rst
similarity index 100%
rename from Documentation/input/notifier.txt
rename to Documentation/input/notifier.rst
diff --git a/Documentation/input/ntrig.txt b/Documentation/input/ntrig.rst
similarity index 100%
rename from Documentation/input/ntrig.txt
rename to Documentation/input/ntrig.rst
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.rst
similarity index 100%
rename from Documentation/input/rotary-encoder.txt
rename to Documentation/input/rotary-encoder.rst
diff --git a/Documentation/input/sentelic.txt b/Documentation/input/sentelic.rst
similarity index 100%
rename from Documentation/input/sentelic.txt
rename to Documentation/input/sentelic.rst
diff --git a/Documentation/input/userio.txt b/Documentation/input/userio.rst
similarity index 100%
rename from Documentation/input/userio.txt
rename to Documentation/input/userio.rst
diff --git a/Documentation/input/walkera0701.txt b/Documentation/input/walkera0701.rst
similarity index 100%
rename from Documentation/input/walkera0701.txt
rename to Documentation/input/walkera0701.rst
diff --git a/Documentation/input/xpad.txt b/Documentation/input/xpad.rst
similarity index 100%
rename from Documentation/input/xpad.txt
rename to Documentation/input/xpad.rst
diff --git a/Documentation/input/yealink.txt b/Documentation/input/yealink.rst
similarity index 100%
rename from Documentation/input/yealink.txt
rename to Documentation/input/yealink.rst
-- 
2.9.3


