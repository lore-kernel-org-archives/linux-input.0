From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 3/5] input.h: add keycodes for Fn Lock
Date: Mon, 29 Jul 2013 00:59:37 -0300
Message-ID: <1375070379-329-3-git-send-email-m.chehab@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56916 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3G2D7q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 23:59:46 -0400
In-Reply-To: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

Samsung notebooks have a FN LOCK key. It works like CAPS LOCK or NUM
LOCK keys.

When FN LOCK key is pressed, any further press to a key with a blue label
on it (Fn keys) will produce the alternate code.

Another press makes the keyboard to return to its normal state.

On the notebooks where such feature were found, a FN LOCK on event
produces scancode 0xa8, and a FN LOCK off event produces scancode 0xa9.

Yet, it is better to reserve some space at the keymap to allow some
different implementation of this feature where the same keycode might
be used.

Also, as this is actually a switch, add a switch indicator to report
when this switch is set/reset.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 include/uapi/linux/input.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index d584047..4622c34 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -716,6 +716,10 @@ struct input_keymap_entry {
 #define BTN_DPAD_LEFT		0x222
 #define BTN_DPAD_RIGHT		0x223
 
+#define KEY_FNLOCK_TOGGLE	0x224	/* Request switch Fn on or off */
+#define KEY_FNLOCK_ON		0x225
+#define KEY_FNLOCK_OFF		0x226
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
@@ -853,6 +857,7 @@ struct input_keymap_entry {
 #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
+#define SW_FNLOCK		0x0e  /* set = Fn locked */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.8.3.1

