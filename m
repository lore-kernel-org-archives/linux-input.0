From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] HID: wacom: ask for a in-prox report when it was missed
Date: Thu,  5 Mar 2015 17:36:54 -0500
Message-ID: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbbCEWhA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Mar 2015 17:37:00 -0500
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
To make some generation of hardware working, we need to unset the
quirk NO_GET set by hid-core because the interfaces are seen as "boot
mouse".

We don't schedule this read in a worker while we are in an IO interrupt.
We know that usbhid will do it asynchronously. If this is triggered by
uhid, then this is obviously a client side bug :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Change in v2:
- commit message amended (a little)
- unset the flag HID_QUIRK_NO_GET to make the code compatible with Intuos 3 and
  4

 drivers/hid/wacom_sys.c |  3 +++
 drivers/hid/wacom_wac.c | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 957699f..22cac9d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1389,6 +1389,9 @@ static int wacom_probe(struct hid_device *hdev,
 
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
+	/* hid-core sets this quirk for the boot interface */
+	hdev->quirks &= ~HID_QUIRK_NOGET;
+
 	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
 	if (!wacom)
 		return -ENOMEM;
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

