From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/7] HID: wacom: Move handling of Intuos status packets to seperate function
Date: Fri,  6 Mar 2015 11:47:31 -0800
Message-ID: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33797 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbbCFTru (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:47:50 -0500
Received: by paceu11 with SMTP id eu11so40016924pac.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:47:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

In addition to the touchswitch state for "Intuos", these packets are
also sent by the Intuos Pro, Intuos5, and last-generation Bamboo
tablets when using a wired connection. They contain, among other
things, information about the optional wireless module and battery
charge state (to be supported in subsuquent patches).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 36 +++++++++++++++++++++++-------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bbf72f9..cb308c5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1740,20 +1740,9 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
 
-	if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_USB)
+	if (data[0] != WACOM_REPORT_PENABLED)
 	    return 0;
 
-	if (data[0] == WACOM_REPORT_USB) {
-		if (features->type == INTUOSHT &&
-		    wacom->shared->touch_input &&
-		    features->touch_max) {
-			input_report_switch(wacom->shared->touch_input,
-					    SW_MUTE_DEVICE, data[8] & 0x40);
-			input_sync(wacom->shared->touch_input);
-		}
-		return 0;
-	}
-
 	prox = (data[1] & 0x20) == 0x20;
 
 	/*
@@ -1960,6 +1949,24 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
+static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
+{
+	struct wacom_features *features = &wacom_wac->features;
+	unsigned char *data = wacom_wac->data;
+
+	if (data[0] != WACOM_REPORT_USB)
+		return 0;
+
+	if (features->type == INTUOSHT &&
+	    wacom_wac->shared->touch_input &&
+	    features->touch_max) {
+		input_report_switch(wacom_wac->shared->touch_input,
+				    SW_MUTE_DEVICE, data[8] & 0x40);
+		input_sync(wacom_wac->shared->touch_input);
+	}
+	return 0;
+}
+
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	bool sync;
@@ -2044,7 +2051,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	case BAMBOO_PT:
 	case INTUOSHT:
-		sync = wacom_bpt_irq(wacom_wac, len);
+		if (wacom_wac->data[0] == WACOM_REPORT_USB)
+			sync = wacom_status_irq(wacom_wac, len);
+		else
+			sync = wacom_bpt_irq(wacom_wac, len);
 		break;
 
 	case BAMBOO_PAD:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index a3d0828..ee6a545 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -71,6 +71,7 @@
 #define WACOM_REPORT_USB		192
 #define WACOM_REPORT_BPAD_PEN		3
 #define WACOM_REPORT_BPAD_TOUCH		16
+#define WACOM_PKGLEN_STATUS		10
 
 /* device quirks */
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
-- 
2.3.0

