From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 27/33] docs: input/walkera0701: convert it to ReST format
Date: Tue,  4 Apr 2017 07:52:37 -0300
Message-ID: <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491302719.git.mchehab@s-opensource.com>
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
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <679c283194489e852074900b0133b5b6acd9395f.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

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


