From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Input: Add keycodes for touchpad on/off keys
Date: Mon, 08 Nov 2010 12:42:10 +0000
Message-ID: <1289220130.5418.109.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:60491 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab0KHMmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 07:42:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some laptops will have a "touchpad toggle" soft button, which
expects user-space to turn off the touchpad themselves, some
other devices will do this in hardware, but send key events telling
us that the touchpad has been turned off/on.

KEY_TOUCHPAD_ON/KEY_TOUCHPAD_OFF will be used by user-space to
show a popup with the status of the touchpad.

Signed-Off-By: Bastien Nocera <hadess@hadess.net>
---
 include/linux/input.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 896a922..46dca75 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -545,6 +545,10 @@ struct input_absinfo {
 #define KEY_CONTEXT_MENU	0x1b6	/* GenDesc - system context menu */
 #define KEY_MEDIA_REPEAT	0x1b7	/* Consumer - transport control */
 
+#define KEY_TOUCHPAD_TOGGLE	0x1b8	/* Ask user-space to switch the touchpad off */
+#define KEY_TOUCHPAD_ON		0x1b9	/* Tell user-space touchpad is now on */
+#define KEY_TOUCHPAD_OFF	0x1ba	/* As above but off */
+
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
 #define KEY_INS_LINE		0x1c2
-- 
1.7.3.2


