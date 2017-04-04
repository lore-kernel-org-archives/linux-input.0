From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 35/37] input: add a EV_SW event for ratchet switch
Date: Tue,  4 Apr 2017 09:22:35 -0300
Message-ID: <dd545ad8f1ac0f3d9580815248c7c68ec244a9f9.1491308444.git.mchehab@s-opensource.com>
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
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491308444.git.mchehab@s-opensource.com>
 <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491308444.git.mchehab@s-opensource.com>
 <a6e09069e3a232652651c2aac6d0906e728422e2.1491308444.git.mchehab@s-opensource.com>
 <a016a7ed8bf8b5e9f292f188c0763a15937c28c5.1491308444.git.mchehab@s-opensource.com>
 <178fde32a3be0f5b05dc60787f6a96c704960bbb.1491308444.git.mchehab@s-opensource.com>
 <c0f94891efafd6b7c18766ce3e42b82cf805f813.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34584
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752909AbdDDMXE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:04 -0400
In-Reply-To: <c0f94891efafd6b7c18766ce3e42b82cf805f813.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Hutterer <peter.hutterer@who-t.net>, Stuart Yoder <stuart.yoder@nxp.com>, "David S. Miller" <davem@davemloft.net>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Florian Fainelli <f.fainelli@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Ping Cheng <pinglinux@gmail.com>, Douglas Anderson <dianders@chromium.org>, Kamil Debski <kamil@wypas.org>

Some mouses have a switch on their wheel, allowing to switch
between ratchet or free wheel mode. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/event-codes.rst    | 16 ++++++++++++++++
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h |  4 +++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index 0c8591d39bc6..93f14f0ddb3d 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -239,6 +239,22 @@ Upon resume, if the switch state is the same as before suspend, then the input
 subsystem will filter out the duplicate switch state reports. The driver does
 not need to keep the state of the switch at any time.
 
+A few EV_SW codes have special meanings:
+
+* SW_RATCHET:
+
+  - Some mouses have a special switch at their wheel that allows to change
+    from free wheel mode to ratchet mode.
+
+    When such switch is ratchet mode (ON state), the wheel will offer some
+    resistance for movements movement. It will also provide a tactile
+    feedback when scrolled.
+
+    When pressed while in ratchet mode, the wheel will switch to free wheel
+    mode (OFF state). In this mode, it will offer no resistance to wheel
+    movements nor any tactile feedback. Pressing again returns to ratchet
+    mode.
+
 EV_MSC
 ------
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 8850fcaf50db..038cddf1436a 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -292,7 +292,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
 #define INPUT_DEVICE_ID_MATCH_VENDOR	2
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 23b2d377af59..a3eafd0527f1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -782,7 +782,9 @@
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
-#define SW_MAX			0x0f
+#define SW_RATCHET		0x10  /* set = ratchet mode,
+					 unset: free wheel */
+#define SW_MAX			0x1f
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.9.3

