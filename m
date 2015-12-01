From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 7/7] HID: wacom: Rename wacom ID report ID macros
Date: Mon, 30 Nov 2015 17:13:52 -0800
Message-ID: <1448932432-10115-7-git-send-email-killertofu@gmail.com>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32988 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbbLABOA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 20:14:00 -0500
Received: by pabfh17 with SMTP id fh17so208552157pab.0
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2015 17:14:00 -0800 (PST)
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

"INTUOSREAD" and "INTUOSWRITE" are poorly named. These are report IDs
for pen ID (proximity) packets. It should be noted that the latter is
only used on Intuos/Intuos2 for a second stylus when DualTrack is in use.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 6 +++---
 drivers/hid/wacom_wac.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0008650..3953416 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -443,7 +443,7 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 	struct hid_report_enum *re;
 
 	re = &(wacom->hdev->report_enum[HID_FEATURE_REPORT]);
-	r = re->report_id_hash[WACOM_REPORT_INTUOSREAD];
+	r = re->report_id_hash[WACOM_REPORT_INTUOS_ID1];
 	if (r) {
 		hid_hw_request(wacom->hdev, r, HID_REQ_GET_REPORT);
 	}
@@ -1027,8 +1027,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	int result;
 
 	if (data[0] != WACOM_REPORT_PENABLED &&
-	    data[0] != WACOM_REPORT_INTUOSREAD &&
-	    data[0] != WACOM_REPORT_INTUOSWRITE &&
+	    data[0] != WACOM_REPORT_INTUOS_ID1 &&
+	    data[0] != WACOM_REPORT_INTUOS_ID2 &&
 	    data[0] != WACOM_REPORT_INTUOSPAD &&
 	    data[0] != WACOM_REPORT_INTUOS_PEN &&
 	    data[0] != WACOM_REPORT_CINTIQ &&
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 877c24a..3f60192 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -47,8 +47,8 @@
 /* wacom data packet report IDs */
 #define WACOM_REPORT_PENABLED		2
 #define WACOM_REPORT_PENABLED_BT	3
-#define WACOM_REPORT_INTUOSREAD		5
-#define WACOM_REPORT_INTUOSWRITE	6
+#define WACOM_REPORT_INTUOS_ID1		5
+#define WACOM_REPORT_INTUOS_ID2		6
 #define WACOM_REPORT_INTUOSPAD		12
 #define WACOM_REPORT_INTUOS5PAD		3
 #define WACOM_REPORT_DTUSPAD		21
-- 
2.6.2

