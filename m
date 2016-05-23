From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom_w8001 - W8001_MAX_LENGTH should be 13
Date: Sun, 22 May 2016 22:26:13 -0700
Message-ID: <1463981173-9866-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34362 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbcEWF0Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 01:26:25 -0400
Received: by mail-pa0-f65.google.com with SMTP id yl2so16785417pac.1
        for <linux-input@vger.kernel.org>; Sun, 22 May 2016 22:26:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, christopherarges@gmail.com
Cc: dmitry.torokhov@gmail.com, wacom <wacom@localhost.localdomain>, Ping Cheng <pingc@wacom.com>

From: wacom <wacom@localhost.localdomain>

I guess the patch that added two-finger touch support forgot to update
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
1.8.3.1

