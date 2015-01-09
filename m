From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Process invalid Cintiq and Intuos data in wacom_intuos_inout
Date: Fri,  9 Jan 2015 11:04:50 -0800
Message-ID: <1420830290-5053-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39923 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbAITE4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 14:04:56 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so20124059pab.5
        for <linux-input@vger.kernel.org>; Fri, 09 Jan 2015 11:04:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Users may use unsupported tools on Cintiq or Intuos. When invalid
tools or data are detected, they should be ignored. That is, no
event from those tools should be reported.

Consolidating that code in wacom_intuos_inout simplifies the logic
and make it easier for future code change.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v2: Added commit comments as suggested by Jiri Kosina.
---
 drivers/hid/wacom_wac.c | 50 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 596a6fb5..5276689 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -534,9 +534,24 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		return 1;
 	}
 
+	/*
+	 * don't report events for invalid data
+	 */
 	/* older I4 styli don't work with new Cintiqs */
-	if (!((wacom->id[idx] >> 20) & 0x01) &&
-			(features->type == WACOM_21UX2))
+	if ((!((wacom->id[idx] >> 20) & 0x01) &&
+			(features->type == WACOM_21UX2)) ||
+	    /* Only large Intuos support Lense Cursor */
+	    (wacom->tool[idx] == BTN_TOOL_LENS &&
+		(features->type == INTUOS3 ||
+		 features->type == INTUOS3S ||
+		 features->type == INTUOS4 ||
+		 features->type == INTUOS4S ||
+		 features->type == INTUOS5 ||
+		 features->type == INTUOS5S ||
+		 features->type == INTUOSPM ||
+		 features->type == INTUOSPS)) ||
+	   /* Cintiq doesn't send data when RDY bit isn't set */
+	   (features->type == CINTIQ && !(data[1] & 0x40)))
 		return 1;
 
 	/* Range Report */
@@ -553,6 +568,10 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = false;
 
+		/* don't report exit if we don't know the ID */
+		if (!wacom->id[idx])
+			return 1;
+
 		/*
 		 * Reset all states otherwise we lose the initial states
 		 * when in-prox next time
@@ -585,6 +604,11 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		wacom->id[idx] = 0;
 		return 2;
 	}
+
+	/* don't report other events if we don't know the ID */
+	if (!wacom->id[idx])
+		return 1;
+
 	return 0;
 }
 
@@ -842,28 +866,6 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	if (result)
                 return result - 1;
 
-	/* don't proceed if we don't know the ID */
-	if (!wacom->id[idx])
-		return 0;
-
-	/* Only large Intuos support Lense Cursor */
-	if (wacom->tool[idx] == BTN_TOOL_LENS &&
-	    (features->type == INTUOS3 ||
-	     features->type == INTUOS3S ||
-	     features->type == INTUOS4 ||
-	     features->type == INTUOS4S ||
-	     features->type == INTUOS5 ||
-	     features->type == INTUOS5S ||
-	     features->type == INTUOSPM ||
-	     features->type == INTUOSPS)) {
-
-		return 0;
-	}
-
-	/* Cintiq doesn't send data when RDY bit isn't set */
-	if (features->type == CINTIQ && !(data[1] & 0x40))
-                 return 0;
-
 	if (features->type >= INTUOS3S) {
 		input_report_abs(input, ABS_X, (data[2] << 9) | (data[3] << 1) | ((data[9] >> 1) & 1));
 		input_report_abs(input, ABS_Y, (data[4] << 9) | (data[5] << 1) | (data[9] & 1));
-- 
1.9.1

