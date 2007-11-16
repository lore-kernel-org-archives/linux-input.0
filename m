From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] Input - Move KEY_{EURO, DOLLAR} to lower keycodes
Date: Fri, 16 Nov 2007 13:41:58 +0000
Message-ID: <200711161341.58696.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:56374 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612AbXKPNmv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 08:42:51 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

From: Carlos Corbacho <cathectic@gmail.com>

These keys are used on PS/2 controllers, so their current values are too
high to map the scancodes to. Move them to the < 256 range.

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
This is one solution to my previously posted problem - just move the keycodes
to ones that can be used by setkeycodes.

 include/linux/input.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index d423cf1..94c3c4b 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -371,6 +371,9 @@ struct input_absinfo {
 #define KEY_BRIGHTNESS_ZERO	244	/* brightness off, use ambient */
 #define KEY_DISPLAY_OFF		245	/* display device to off state */
 
+#define KEY_DOLLAR		246
+#define KEY_EURO		247
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
@@ -527,9 +530,6 @@ struct input_absinfo {
 #define KEY_SPELLCHECK		0x1b0   /* AL Spell Check */
 #define KEY_LOGOFF		0x1b1   /* AL Logoff */
 
-#define KEY_DOLLAR		0x1b2
-#define KEY_EURO		0x1b3
-
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1
 #define KEY_INS_LINE		0x1c2
-- 
1.5.3.3

