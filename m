From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] HID: wacom: Remove comparison of u8 mode with zero and simplify.
Date: Sun,  2 Jul 2017 22:54:23 +0100
Message-ID: <1499032463-22425-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35088 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdGBVy3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Jul 2017 17:54:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>

Variable mode in method wacom_show_remote_mode() is defined as u8, thus
statement (mode >= 0) is always true and should be removed, simplifying
the logic.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/hid/wacom_sys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 838c1eb..79c3d7f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1671,10 +1671,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 	u8 mode;
 
 	mode = wacom->led.groups[index].select;
-	if (mode >= 0 && mode < 3)
-		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
-	else
-		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
+	return snprintf(buf, PAGE_SIZE, "%d\n", mode < 3 ? mode : -1);
 }
 
 #define DEVICE_EKR_ATTR_GROUP(SET_ID)					\
-- 
2.7.4

