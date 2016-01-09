From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] HID: wacom - make sure wacom_intuos_inout only process in/out events
Date: Fri,  8 Jan 2016 17:15:48 -0800
Message-ID: <1452302148-5561-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33006 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbcAIBP5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 20:15:57 -0500
Received: by mail-pf0-f196.google.com with SMTP id e65so1313925pfe.0
        for <linux-input@vger.kernel.org>; Fri, 08 Jan 2016 17:15:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

Move general events related data validation to wacom_intuos_general.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 51 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6449547..8507028 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -576,12 +576,13 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
-	int idx = 0;
-
-	/* tool number */
-	if (features->type == INTUOS)
-		idx = data[1] & 0x01;
+	int idx = (features->type == INTUOS) ? (data[1] & 0x01) : 0;
 
+	if (!(((data[1] & 0xfc) == 0xc0) ||  /* in prox */
+	    ((data[1] & 0xfe) == 0x20) ||    /* in range */
+	    ((data[1] & 0xfe) == 0x80)))     /* out prox */
+		return 0;
+
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
@@ -672,26 +673,6 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		return 1;
 	}
 
-	/*
-	 * don't report events for invalid data
-	 */
-	/* older I4 styli don't work with new Cintiqs */
-	if ((!((wacom->id[idx] >> 20) & 0x01) &&
-			(features->type == WACOM_21UX2)) ||
-	    /* Only large Intuos support Lense Cursor */
-	    (wacom->tool[idx] == BTN_TOOL_LENS &&
-		(features->type == INTUOS3 ||
-		 features->type == INTUOS3S ||
-		 features->type == INTUOS4 ||
-		 features->type == INTUOS4S ||
-		 features->type == INTUOS5 ||
-		 features->type == INTUOS5S ||
-		 features->type == INTUOSPM ||
-		 features->type == INTUOSPS)) ||
-	   /* Cintiq doesn't send data when RDY bit isn't set */
-	   (features->type == CINTIQ && !(data[1] & 0x40)))
-		return 1;
-
 	wacom->shared->stylus_in_proximity = true;
 	if (wacom->shared->touch_down)
 		return 1;
@@ -893,6 +874,26 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		return 1;
 	}
 
+	/*
+	 * don't report events for invalid data
+	 */
+	/* older I4 styli don't work with new Cintiqs */
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
+		return 1;
+
 	x = (be16_to_cpup((__be16 *)&data[2]) << 1) | ((data[9] >> 1) & 1);
 	y = (be16_to_cpup((__be16 *)&data[4]) << 1) | (data[9] & 1);
 	distance = data[9] >> 2;
-- 
1.9.1

