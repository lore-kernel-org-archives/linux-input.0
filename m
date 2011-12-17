From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] input: wacom - use switch statement for wacom_tpc_irq()
Date: Fri, 16 Dec 2011 16:38:02 -0800
Message-ID: <1324082282-32762-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61312 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab1LQAgE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Dec 2011 19:36:04 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5096969iae.19
        for <linux-input@vger.kernel.org>; Fri, 16 Dec 2011 16:36:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

And add two new data formats.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   24 ++++++++++++++++++------
 drivers/input/tablet/wacom_wac.h |    2 ++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 33a4359..8dc185d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -833,12 +833,24 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	dbg("wacom_tpc_irq: received report #%d with %d contacts",
 	     data[0], wacom->features.touch_max);
 
-	if (len == WACOM_PKGLEN_TPC1FG || data[0] == WACOM_REPORT_TPC1FG)
-		return wacom_tpc_single_touch(wacom, len);
-	else if (data[0] == WACOM_REPORT_TPC2FG)
-		return wacom_tpc_mt_touch(wacom);
-	else if (data[0] == WACOM_REPORT_PENABLED)
-		return wacom_tpc_pen(wacom);
+	switch (len) {
+	case WACOM_PKGLEN_TPC1FG:
+		 return wacom_tpc_single_touch(wacom, len);
+
+	case WACOM_PKGLEN_TPC2FG:
+ 		return wacom_tpc_mt_touch(wacom);
+
+	default:
+		switch (data[0]) {
+		case WACOM_REPORT_TPC1FG:
+		case WACOM_REPORT_TPCHID:
+		case WACOM_REPORT_TPCST:
+			return wacom_tpc_single_touch(wacom, len);
+
+		case WACOM_REPORT_PENABLED:
+			return wacom_tpc_pen(wacom);
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 6ddd2e4..1c9dc3e 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -39,6 +39,8 @@
 #define WACOM_REPORT_INTUOSPAD		12
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
+#define WACOM_REPORT_TPCHID		15
+#define WACOM_REPORT_TPCST		16
 
 /* device quirks */
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
-- 
1.7.6.4

