From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] HID: wacom: Remove comparison of u8 mode with zero and simplify.
Date: Sun,  2 Jul 2017 23:46:42 +0100
Message-ID: <1499035602-28437-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36786 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdGBWqs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Jul 2017 18:46:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>

Variable mode in method wacom_show_remote_mode() is defined as u8, thus
statement (mode >= 0) is always true and should be removed, simplifying
the logic.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/hid/wacom_sys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 838c1eb..ae2408d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1671,10 +1671,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 	u8 mode;
 
 	mode = wacom->led.groups[index].select;
-	if (mode >= 0 && mode < 3)
-		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
-	else
-		return snprintf(buf, PAGE_SIZE, "%d\n", -1);
+	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
 }
 
 #define DEVICE_EKR_ATTR_GROUP(SET_ID)					\
-- 
2.7.4

