From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 06/21 v5] Input: atmel_mxt_ts - use scnprintf for object sysfs entry
Date: Tue, 26 Jun 2012 14:56:54 +0800
Message-ID: <1340693829-18665-7-git-send-email-djkurtz@chromium.org>
References: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f74.google.com ([209.85.214.74]:37282 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab2FZG5U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 02:57:20 -0400
Received: by bkty5 with SMTP id y5so286114bkt.1
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 23:57:19 -0700 (PDT)
In-Reply-To: <1340693829-18665-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org
Cc: Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

Using scnprintf() is a cleaner way to ensure that we don't overwrite the
PAGE_SIZE sysfs output buffer.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 9f8dd97..55855b8 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -904,17 +904,13 @@ static ssize_t mxt_object_show(struct device *dev,
 	for (i = 0; i < data->info.object_num; i++) {
 		object = data->object_table + i;
 
-		count += snprintf(buf + count, PAGE_SIZE - count,
+		count += scnprintf(buf + count, PAGE_SIZE - count,
 				"Object[%d] (Type %d)\n",
 				i + 1, object->type);
-		if (count >= PAGE_SIZE)
-			return PAGE_SIZE - 1;
 
 		if (!mxt_object_readable(object->type)) {
-			count += snprintf(buf + count, PAGE_SIZE - count,
+			count += scnprintf(buf + count, PAGE_SIZE - count,
 					"\n");
-			if (count >= PAGE_SIZE)
-				return PAGE_SIZE - 1;
 			continue;
 		}
 
@@ -924,15 +920,11 @@ static ssize_t mxt_object_show(struct device *dev,
 			if (error)
 				return error;
 
-			count += snprintf(buf + count, PAGE_SIZE - count,
+			count += scnprintf(buf + count, PAGE_SIZE - count,
 					"\t[%2d]: %02x (%d)\n", j, val, val);
-			if (count >= PAGE_SIZE)
-				return PAGE_SIZE - 1;
 		}
 
-		count += snprintf(buf + count, PAGE_SIZE - count, "\n");
-		if (count >= PAGE_SIZE)
-			return PAGE_SIZE - 1;
+		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
 	}
 
 	return count;
-- 
1.7.7.3

