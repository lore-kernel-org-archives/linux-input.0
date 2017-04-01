From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 27/33] docs: input/walkera0701: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:10 -0300
Message-ID: <2aece6cda8b5835832b4a3987c8818697aacc583.1491069870.git.mchehab@s-opensource.com>
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
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdDASQf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:35 -0400
In-Reply-To: <84c4c711e5b98aafca81460742d5c25fbb24474b.1491069870.git.mchehab@s-opensource.com>
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
 Documentation/input/walkera0701.txt | 53 +++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/Documentation/input/walkera0701.txt b/Documentation/input/walkera0701.txt
index 49e3ac60dcef..2adda99ca717 100644
--- a/Documentation/input/walkera0701.txt
+++ b/Documentation/input/walkera0701.txt
@@ -1,3 +1,6 @@
+===========================
+Walkera WK-0701 transmitter
+===========================
 
 Walkera WK-0701 transmitter is supplied with a ready to fly Walkera
 helicopters such as HM36, HM37, HM60. The walkera0701 module enables to use
@@ -10,7 +13,8 @@ or use cogito:
 cg-clone http://zub.fei.tuke.sk/GIT/walkera0701-joystick
 
 
-Connecting to PC:
+Connecting to PC
+================
 
 At back side of transmitter S-video connector can be found. Modulation
 pulses from processor to HF part can be found at pin 2 of this connector,
@@ -19,7 +23,8 @@ modulation pulses to PC, signal pulses must be amplified.
 
 Cable: (walkera TX to parport)
 
-Walkera WK-0701 TX S-VIDEO connector:
+Walkera WK-0701 TX S-VIDEO connector::
+
  (back side of TX)
      __   __              S-video:                                  canon25
     /  |_|  \             pin 2 (signal)              NPN           parport
@@ -30,10 +35,10 @@ Walkera WK-0701 TX S-VIDEO connector:
      -------        3 __________________________________|________________ 25 GND
                                                           E
 
-
 I use green LED and BC109 NPN transistor.
 
-Software:
+Software
+========
 
 Build kernel with walkera0701 module. Module walkera0701 need exclusive
 access to parport, modules like lp must be unloaded before loading
@@ -44,7 +49,8 @@ be changed by TX "joystick", check output from /proc/interrupts. Value for
 
 
 
-Technical details:
+Technical details
+=================
 
 Driver use interrupt from parport ACK input bit to measure pulse length
 using hrtimers.
@@ -53,17 +59,29 @@ Frame format:
 Based on walkera WK-0701 PCM Format description by Shaul Eizikovich.
 (downloaded from http://www.smartpropoplus.com/Docs/Walkera_Wk-0701_PCM.pdf)
 
-Signal pulses:
-                   (ANALOG)
-    SYNC      BIN   OCT
-  +---------+      +------+
-  |         |      |      |
---+         +------+      +---
-
-Frame:
+Signal pulses
+-------------
+
+::
+
+                     (ANALOG)
+      SYNC      BIN   OCT
+    +---------+      +------+
+    |         |      |      |
+  --+         +------+      +---
+
+Frame
+-----
+
+::
+
  SYNC , BIN1, OCT1, BIN2, OCT2 ... BIN24, OCT24, BIN25, next frame SYNC ..
 
-pulse length:
+pulse length
+------------
+
+::
+
    Binary values:		Analog octal values:
 
    288 uS Binary 0		318 uS       000
@@ -80,7 +98,8 @@ pulse length:
 (Warning, pulses on ACK are inverted by transistor, irq is raised up on sync
 to bin change or octal value to bin change).
 
-Binary data representations:
+Binary data representations
+---------------------------
 
 One binary and octal value can be grouped to nibble. 24 nibbles + one binary
 values can be sampled between sync pulses.
@@ -100,10 +119,10 @@ binary value can be sampled. This bit and magic number is not used in
 software driver. Some details about this magic numbers can be found in
 Walkera_Wk-0701_PCM.pdf.
 
-Checksum calculation:
+Checksum calculation
+--------------------
 
 Summary of octal values in nibbles must be same as octal value in checksum
 nibble (only first 3 bits are used). Binary value for checksum nibble is
 calculated by sum of binary values in checked nibbles + sum of octal values
 in checked nibbles divided by 8. Only bit 0 of this sum is used.
-
-- 
2.9.3


