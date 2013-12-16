From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Input: add short note about ABS_MISC+<n> axes
Date: Mon, 16 Dec 2013 16:23:06 +0100
Message-ID: <1387207386-4601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:62433 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab3LPPXn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 10:23:43 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so2286774eek.22
        for <linux-input@vger.kernel.org>; Mon, 16 Dec 2013 07:23:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

We must not reassign those axes or we will break backwards-compat. Add a
small note for that so we don't accidentally some day reuse these.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/uapi/linux/input.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a372627..da1125e 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -816,6 +816,10 @@ struct input_keymap_entry {
 
 #define ABS_MISC		0x28
 
+/* ABS_MISC+x is used by HID to assign to unknown axes. Note that they used to
+ * flow over into the MT definitions. For backwards-compatibility, we must
+ * not reassign [0x29-0x2e] */
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
-- 
1.8.5.1

