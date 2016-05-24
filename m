From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Input: wacom_w8001 - W8001_MAX_LENGTH should be 13
Date: Mon, 23 May 2016 20:03:40 -0700
Message-ID: <1464059020-6205-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34531 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbcEXDEB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 23:04:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so590570pfz.1
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 20:04:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: peter.hutterer@who-t.net, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

Somehow the patch that added two-finger touch support forgot to update
W8001_MAX_LENGTH from 11 to 13.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index bab3c6a..b1b4127 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -27,7 +27,7 @@ MODULE_AUTHOR("Jaya Kumar <jayakumar.lkml@gmail.com>");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-#define W8001_MAX_LENGTH	11
+#define W8001_MAX_LENGTH	13
 #define W8001_LEAD_MASK		0x80
 #define W8001_LEAD_BYTE		0x80
 #define W8001_TAB_MASK		0x40
-- 
1.9.1

