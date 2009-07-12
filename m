From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] input: add Hold on/off and volume event keys
Date: Sun, 12 Jul 2009 17:33:37 +0200
Message-ID: <4A5A0251.8010803@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:49554 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbZGLPdl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2009 11:33:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Recent Acer laptops produce key events when the Hold button on the media
control panel is activated and deactivated. These events are relevant
for software that wishes to interact with the media panel beyond just
using the media control keys.

There's also a volume notification key event that replaces the usual
volume-up/down events when the panel is in software-controlled mode.
Software can react to this to detect volume level changes instead of
polling.

Signed-off-by: Hector Martin <hector@marcansoft.com>
--- linux-2.6.30/include/linux/input.h.old	2009-07-12 17:22:53.000000000 +0200
+++ linux-2.6.30/include/linux/input.h	2009-07-12 17:25:01.000000000 +0200
@@ -543,6 +543,10 @@
 #define KEY_CONTEXT_MENU	0x1b6	/* GenDesc - system context menu */
 #define KEY_MEDIA_REPEAT	0x1b7	/* Consumer - transport control */
 
+#define KEY_VOLUME_EVENT	0x1b8	/* Generic volume change event */
+#define KEY_HOLDON		0x1b9	
+#define KEY_HOLDOFF		0x1ba
+
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
 #define KEY_INS_LINE		0x1c2

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

