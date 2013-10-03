From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input - input.h: Add a new switch event
Date: Thu,  3 Oct 2013 15:31:07 -0700
Message-ID: <1380839467-27264-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:56872 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab3JCWbO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Oct 2013 18:31:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, benjamin.tissoires@gmail.com, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

One of Wacom's pen and touch capable models added a switch for
users to turn on/off touch events. We need to report the state of
this switch to userland. But, there is no existing switch event
defined for this purpose. Luckily enough, there is a room for a
new switch event.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index d08abf9..d4097b0 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -855,6 +855,7 @@ struct input_keymap_entry {
 #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
+#define SW_TOUCH_ENABLED	0x0e  /* set = touch switch turned on (touch events off) */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
1.8.1.2

