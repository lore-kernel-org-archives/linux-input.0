From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] Input: wacom_w8001 - Ignore invalid pen data packets
Date: Mon, 23 May 2016 20:04:27 -0700
Message-ID: <1464059067-6244-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36567 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcEXDEj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 23:04:39 -0400
Received: by mail-pa0-f67.google.com with SMTP id fg1so561316pad.3
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 20:04:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: peter.hutterer@who-t.net, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

ThinkPad X60 Tablet PC (pen only device) sometime posts
packets that are larger than W8001_PKTLEN_TPCPEN.

Reported-by: Chris J Arges <christopherarges@gmail.com>
Tested-by: Chris J Arges <christopherarges@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index b1b4127..d5dcda2 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -339,6 +339,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 		w8001->idx = 0;
 		parse_multi_touch(w8001);
 		break;
+
+	default:
+		/*
+		 * ThinkPad X60 Tablet PC (pen only device) sometime sends
+		 * invalid data packets that are larger than W8001_PKTLEN_TPCPEN.
+		 * Let's start over again.
+		 */
+		if (!w8001->touch_dev && w8001->idx > W8001_PKTLEN_TPCPEN - 1)
+			w8001->idx = 0;
 	}
 
 	return IRQ_HANDLED;
-- 
1.9.1

