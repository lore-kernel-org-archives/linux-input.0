From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: add new keycodes for passenger control units
Date: Mon, 18 Feb 2013 11:05:55 -0800
Message-ID: <1361214357-21205-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:40634 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3BRTGM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 14:06:12 -0500
In-Reply-To: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Chris Healy <chealy@imsco-us.com>

Entertainment systems used in aircraft need additional keycodes for their
Passenger Control Units, so let's add them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 54a3b49..e6d9609 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -702,6 +702,11 @@ struct input_keymap_entry {
 #define KEY_CAMERA_LEFT		0x219
 #define KEY_CAMERA_RIGHT	0x21a
 
+#define KEY_ATTENDANT_ON	0x21b
+#define KEY_ATTENDANT_OFF	0x21c
+#define KEY_ATTENDANT_TOGGLE	0x21d	/* Attendant call on or off */
+#define KEY_LIGHTS_TOGGLE	0x21e	/* Reading light on or off */
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
-- 
1.7.11.7

