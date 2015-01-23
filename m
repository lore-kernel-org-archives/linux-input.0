From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] input.h: Add BTN_SIDE2 button code
Date: Fri, 23 Jan 2015 11:24:50 +0100
Message-ID: <1422008690-920-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782AbbAWKYy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 05:24:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Some mice report buttons with a MSC_SCAN of 589833 this maps to a button code
of 0x118, add a BTN_SIDE2 define for this to input.h

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1184352
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/uapi/linux/input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a1d7e93..27b0f6a 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -498,6 +498,7 @@ struct input_keymap_entry {
 #define BTN_FORWARD		0x115
 #define BTN_BACK		0x116
 #define BTN_TASK		0x117
+#define BTN_SIDE2		0x118
 
 #define BTN_JOYSTICK		0x120
 #define BTN_TRIGGER		0x120
-- 
2.1.0

