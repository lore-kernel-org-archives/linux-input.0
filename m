From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/2] input: mt: add the ABS_MT_PRESSURE event
Date: Thu, 28 Jan 2010 23:42:48 +0100
Message-ID: <1264718569-9772-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42013 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732Ab0A1WpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2010 17:45:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jy0922.shim@samsung.com, mika.kuoppala@nokia.com, peter.hutterer@who-t.net, Henrik Rydberg <rydberg@euromail.se>

For pressure-based multi-touch devices, a direct way to send sensor
intensity data per finger is needed. This patch adds the ABS_MT_PRESSURE
event to the MT protocol.

Requested-by: Yoonyoung Shim <jy0922.shim@samsung.com>
Requested-by: Mika Kuoppala <mika.kuoppala@nokia.com>
Requested-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/input.c |    1 +
 include/linux/input.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 30b503b..86cb2d2 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -46,6 +46,7 @@ static unsigned int input_abs_bypass_init_data[] __initdata = {
 	ABS_MT_TOOL_TYPE,
 	ABS_MT_BLOB_ID,
 	ABS_MT_TRACKING_ID,
+	ABS_MT_PRESSURE,
 	0
 };
 static unsigned long input_abs_bypass[BITS_TO_LONGS(ABS_CNT)];
diff --git a/include/linux/input.h b/include/linux/input.h
index 7be8a65..735ceaf 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -660,6 +660,7 @@ struct input_absinfo {
 #define ABS_MT_TOOL_TYPE	0x37	/* Type of touching device */
 #define ABS_MT_BLOB_ID		0x38	/* Group a set of packets as a blob */
 #define ABS_MT_TRACKING_ID	0x39	/* Unique ID of initiated contact */
+#define ABS_MT_PRESSURE		0x3a	/* Pressure on contact area */
 
 #define ABS_MAX			0x3f
 #define ABS_CNT			(ABS_MAX+1)
-- 
1.6.3.3

