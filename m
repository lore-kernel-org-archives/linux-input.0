From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 28/33] docs: input/xpad: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:11 -0300
Message-ID: <4f55d4a177f311a1bc1c8ee5547ec53c3f92fefe.1491069870.git.mchehab@s-opensource.com>
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
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52343 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdDASQd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:33 -0400
In-Reply-To: <2aece6cda8b5835832b4a3987c8818697aacc583.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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


