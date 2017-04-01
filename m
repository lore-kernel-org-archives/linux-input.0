From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 30/33] docs-rst: create a book with Linux Input documentation
Date: Sat,  1 Apr 2017 15:16:13 -0300
Message-ID: <721d8a1164997d61e5c0b6e9f4cc300f84643ebc.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
 <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
 <87be2676f773a689c9b39c4f79cd843fb3678133.1491069870.git.mchehab@s-opensource.com>
 <6730cd298d203d22aec9a5a708cd1d15982e624b.1491069870.git.mchehab@s-opensource.com>
 <b9b1a9e27971fd899876825f2ccfd638c6c62668.1491069870.git.mchehab@s-opensource.com>
 <07a688fbc69c47362aca5882a3bcf72329d0fe1a.1491069870.git.mchehab@s-opensource.com>
 <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
 <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
 <74a6c5b672275a8a40317a76c72845a939089c89.1491069870.git.mchehab@s-opensource.com>
 <d55bc5210e28c8c0bb4179e58359a8ff7b234f41.1491069870.git.mchehab@s-opensource.com>
 <84c4c711e5b98aafca81460742d5c25fbb24474b.1491069870.git.mchehab@s-opensource.com>
 <2aece6cda8b5835832b4a3987c8818697aacc583.1491069870.git.mchehab@s-opensource.com>
 <4f55d4a177f311a1bc1c8ee5547ec53c3f92fefe.1491069870.git.mchehab@s-opensource.com>
 <c73bfd1906e067331ed9717d62a2eae4aaf2ce9a.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <c73bfd1906e067331ed9717d62a2eae4aaf2ce9a.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Markus Heiser <markus.heiser@darmarit.de>
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
index 1ac958c0333d..974c9e241527 100644
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
index 4a5932d51992..48a409a6625c 100644
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


