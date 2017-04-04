From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 28/37] docs: input/xpad: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:28 -0300
Message-ID: <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/xpad.txt | 120 ++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 52 deletions(-)

diff --git a/Documentation/input/xpad.txt b/Documentation/input/xpad.txt
index d1b23f295db4..0bae002cf17a 100644
--- a/Documentation/input/xpad.txt
+++ b/Documentation/input/xpad.txt
@@ -1,4 +1,6 @@
+=======================================================
 xpad - Linux USB driver for Xbox compatible controllers
+=======================================================
 
 This driver exposes all first-party and third-party Xbox compatible
 controllers. It has a long history and has enjoyed considerable usage
@@ -15,9 +17,11 @@ the Xbox One's rumble protocol has not been reverse engineered but in
 the future could be supported.
 
 
-0. Notes
---------
+Notes
+=====
+
 The number of buttons/axes reported varies based on 3 things:
+
 - if you are using a known controller
 - if you are using a known dance pad
 - if using an unknown device (one not listed below), what you set in the
@@ -35,8 +39,9 @@ This is not true. Both dpad_to_buttons and triggers_to_buttons only affect
 unknown controllers.
 
 
-0.1 Normal Controllers
-----------------------
+Normal Controllers
+------------------
+
 With a normal controller, the directional pad is mapped to its own X/Y axes.
 The jstest-program from joystick-1.2.15 (jstest-version 2.1.0) will report 8
 axes and 10 buttons.
@@ -55,8 +60,9 @@ in game functionality were OK. However, I find it rather difficult to
 play first person shooters with a pad. Your mileage may vary.
 
 
-0.2 Xbox Dance Pads
--------------------
+Xbox Dance Pads
+---------------
+
 When using a known dance pad, jstest will report 6 axes and 14 buttons.
 
 For dance style pads (like the redoctane pad) several changes
@@ -73,8 +79,9 @@ of buttons, see section 0.3 - Unknown Controllers
 I've tested this with Stepmania, and it works quite well.
 
 
-0.3 Unknown Controllers
-----------------------
+Unknown Controllers
+-------------------
+
 If you have an unknown xbox controller, it should work just fine with
 the default settings.
 
@@ -88,9 +95,11 @@ to the list of supported devices, ensuring that it will work out of the
 box in the future.
 
 
-1. USB adapters
---------------
+USB adapters
+============
+
 All generations of Xbox controllers speak USB over the wire.
+
 - Original Xbox controllers use a proprietary connector and require adapters.
 - Wireless Xbox 360 controllers require a 'Xbox 360 Wireless Gaming Receiver
   for Windows'
@@ -101,8 +110,9 @@ All generations of Xbox controllers speak USB over the wire.
 
 
 
-1.1 Original Xbox USB adapters
---------------
+Original Xbox USB adapters
+--------------------------
+
 Using this driver with an Original Xbox controller requires an
 adapter cable to break out the proprietary connector's pins to USB.
 You can buy these online fairly cheap, or build your own.
@@ -123,8 +133,8 @@ you can still use the controller with your X-Box, if you have one ;)
 
 
 
-2. Driver Installation
-----------------------
+Driver Installation
+===================
 
 Once you have the adapter cable, if needed, and the controller connected
 the xpad module should be auto loaded. To confirm you can cat
@@ -132,13 +142,15 @@ the xpad module should be auto loaded. To confirm you can cat
 
 
 
-3. Supported Controllers
-------------------------
+Supported Controllers
+=====================
+
 For a full list of supported controllers and associated vendor and product
 IDs see the xpad_device[] array[6].
 
 As of the historic version 0.0.6 (2006-10-10) the following devices
-were supported:
+were supported::
+
  original Microsoft XBOX controller (US),    vendor=0x045e, product=0x0202
  smaller  Microsoft XBOX controller (US),    vendor=0x045e, product=0x0289
  original Microsoft XBOX controller (Japan), vendor=0x045e, product=0x0285
@@ -152,14 +164,16 @@ the module option 'dpad_to_buttons'.
 If you have an unrecognized controller please see 0.3 - Unknown Controllers
 
 
-4. Manual Testing
------------------
+Manual Testing
+==============
+
 To test this driver's functionality you may use 'jstest'.
 
-For example:
-> modprobe xpad
-> modprobe joydev
-> jstest /dev/js0
+For example::
+
+    > modprobe xpad
+    > modprobe joydev
+    > jstest /dev/js0
 
 If you're using a normal controller, there should be a single line showing
 18 inputs (8 axes, 10 buttons), and its values should change if you move
@@ -170,57 +184,59 @@ It works? Voila, you're done ;)
 
 
 
-5. Thanks
----------
+Thanks
+======
 
 I have to thank ITO Takayuki for the detailed info on his site
- http://euc.jp/periphs/xbox-controller.ja.html.
- 
+    http://euc.jp/periphs/xbox-controller.ja.html.
+
 His useful info and both the usb-skeleton as well as the iforce input driver
 (Greg Kroah-Hartmann; Vojtech Pavlik) helped a lot in rapid prototyping
 the basic functionality.
 
 
 
-6. References
--------------
+References
+==========
 
 [1]: http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
+
 [2]: http://xpad.xbox-scene.com/
+
 [3]: http://www.markosweb.com/www/xboxhackz.com/
-[4]: /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany):
 
-T:  Bus=01 Lev=03 Prnt=04 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
-D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=32 #Cfgs=  1
-P:  Vendor=05fd ProdID=107a Rev= 1.00
-C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
-I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=(none)
-E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
-E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms
+[4]: /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany)::
 
-[5]: /proc/bus/usb/devices - dump from Redoctane Xbox Dance Pad (US):
+    T:  Bus=01 Lev=03 Prnt=04 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
+    D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=32 #Cfgs=  1
+    P:  Vendor=05fd ProdID=107a Rev= 1.00
+    C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
+    I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=(none)
+    E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
+    E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms
 
-T:  Bus=01 Lev=02 Prnt=09 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
-D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
-P:  Vendor=0c12 ProdID=8809 Rev= 0.01
-S:  Product=XBOX DDR
-C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
-I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=xpad
-E:  Ad=82(I) Atr=03(Int.) MxPS=  32 Ivl=4ms
-E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=4ms
+[5]: /proc/bus/usb/devices - dump from Redoctane Xbox Dance Pad (US)::
+
+    T:  Bus=01 Lev=02 Prnt=09 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
+    D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
+    P:  Vendor=0c12 ProdID=8809 Rev= 0.01
+    S:  Product=XBOX DDR
+    C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
+    I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=xpad
+    E:  Ad=82(I) Atr=03(Int.) MxPS=  32 Ivl=4ms
+    E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=4ms
 
 [6]: http://lxr.free-electrons.com/ident?i=xpad_device
 
 
 
-7. Historic Edits
------------------
-Marko Friedemann <mfr@bmx-chemnitz.de>
-2002-07-16
+Historic Edits
+==============
+
+2002-07-16 - Marko Friedemann <mfr@bmx-chemnitz.de>
  - original doc
 
-Dominic Cerquetti <binary1230@yahoo.com>
-2005-03-19
+2005-03-19 - Dominic Cerquetti <binary1230@yahoo.com>
  - added stuff for dance pads, new d-pad->axes mappings
 
 Later changes may be viewed with 'git log Documentation/input/xpad.txt'
-- 
2.9.3

