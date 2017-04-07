From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v3 2/4] input: add a EV_SW event for ratchet switch
Date: Fri,  7 Apr 2017 08:31:25 -0300
Message-ID: <3f88befad3bce50fe8a9a51549c24ec0b9f3f793.1491564565.git.mchehab@s-opensource.com>
References: <cover.1491564565.git.mchehab@s-opensource.com>
 <dda7b8209731d30b1255c8cbde2efd46f71fae4b.1491564565.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:48299
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933430AbdDGLbw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Apr 2017 07:31:52 -0400
In-Reply-To: <dda7b8209731d30b1255c8cbde2efd46f71fae4b.1491564565.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491564565.git.mchehab@s-opensource.com>
References: <cover.1491564565.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hutterer <peter.hutterer@who-t.net>, Florian Fainelli <f.fainelli@gmail.com>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, Stuart Yoder <stuart.yoder@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hans.verkuil@cisco.com>, Kamil Debski <kamil@wypas.org>, Ping Cheng <pinglinux@gmail.com>, Douglas Anderson <dianders@chromium.org>, linux-doc@vger.kernel.org

Some mice have a switch on their wheel, allowing to switch
between ratchet and free wheel mode. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/event-codes.rst    | 12 ++++++++++++
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h |  4 +++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index 0c8591d39bc6..4cb7eab73e78 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -239,6 +239,18 @@ Upon resume, if the switch state is the same as before suspend, then the input
 subsystem will filter out the duplicate switch state reports. The driver does
 not need to keep the state of the switch at any time.
 
+A few EV_SW codes have special meanings:
+
+* SW_RATCHET:
+
+  - Some mice have a special switch for their wheel that allows to change
+    between free wheel mode and ratchet mode. When the switch is ratchet
+    mode (ON state), the wheel will offer some resistance for movements. It
+    may also provide a tactile feedback when scrolled.
+
+    Note that some mice have a ratchet switch that does not generate a
+    software event.
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

