From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: ask for a in-prox report when it was missed
Date: Tue,  3 Mar 2015 12:20:28 -0500
Message-ID: <1425403228-19841-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46688 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302AbbCCRUf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Mar 2015 12:20:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

If noone listens to the input device when a tool comes in proximity,
the tablet does not send the in-prox event when a client becomes available.
That means that no events will be sent until the tool is taken out of
proximity.

In this situation, ask for the report WACOM_REPORT_INTUOSREAD which will
read the corresponding feature and generate an in-prox event.

We don't schedule this read while we are in an IO interrupt because we
know that usbhid will do it asynchronously. If this is triggered by uhid
then this is obviously a client side bug :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9ec4545..ff9a7ab 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -430,6 +430,19 @@ exit:
 	return retval;
 }
 
+static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
+{
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct hid_report *r;
+	struct hid_report_enum *re;
+
+	re = &(wacom->hdev->report_enum[HID_FEATURE_REPORT]);
+	r = re->report_id_hash[WACOM_REPORT_INTUOSREAD];
+	if (r) {
+		hid_hw_request(wacom->hdev, r, HID_REQ_GET_REPORT);
+	}
+}
+
 static int wacom_intuos_inout(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -609,8 +622,11 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	}
 
 	/* don't report other events if we don't know the ID */
-	if (!wacom->id[idx])
+	if (!wacom->id[idx]) {
+		/* but reschedule a read of the current tool */
+		wacom_intuos_schedule_prox_event(wacom);
 		return 1;
+	}
 
 	return 0;
 }
-- 
2.1.0

