From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: logitech-dj: break out testing of validity of dj_device
Date: Fri, 22 Aug 2014 16:16:06 -0400
Message-ID: <1408738566-6805-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1408738566-6805-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408738566-6805-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We can do once the test of the validity of the dj_device, which removes
some duplicated code in various functions.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-dj.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 9bf8637..71f5692 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -385,18 +385,6 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 
 	djdev = djrcv_dev->paired_dj_devices[dj_report->device_index];
 
-	if (!djdev) {
-		dbg_hid("djrcv_dev->paired_dj_devices[dj_report->device_index]"
-			" is NULL, index %d\n", dj_report->device_index);
-		kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
-
-		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
-		}
-		return;
-	}
-
 	memset(reportbuffer, 0, sizeof(reportbuffer));
 
 	for (i = 0; i < NUMBER_OF_HID_REPORTS; i++) {
@@ -421,18 +409,6 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 
 	dj_device = djrcv_dev->paired_dj_devices[dj_report->device_index];
 
-	if (dj_device == NULL) {
-		dbg_hid("djrcv_dev->paired_dj_devices[dj_report->device_index]"
-			" is NULL, index %d\n", dj_report->device_index);
-		kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
-
-		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
-		}
-		return;
-	}
-
 	if ((dj_report->report_type > ARRAY_SIZE(hid_reportid_size_map) - 1) ||
 	    (hid_reportid_size_map[dj_report->report_type] == 0)) {
 		dbg_hid("invalid report type:%x\n", dj_report->report_type);
@@ -701,8 +677,17 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 	}
 
 	spin_lock_irqsave(&djrcv_dev->lock, flags);
+
+	if (!djrcv_dev->paired_dj_devices[dj_report->device_index]) {
+		/* received an event for an unknown device, bail out */
+		logi_dj_recv_queue_notification(djrcv_dev, dj_report);
+		goto out;
+	}
+
 	switch (dj_report->report_type) {
 	case REPORT_TYPE_NOTIF_DEVICE_PAIRED:
+		/* pairing notifications are handled above the switch */
+		break;
 	case REPORT_TYPE_NOTIF_DEVICE_UNPAIRED:
 		logi_dj_recv_queue_notification(djrcv_dev, dj_report);
 		break;
@@ -715,6 +700,8 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 	default:
 		logi_dj_recv_forward_report(djrcv_dev, dj_report);
 	}
+
+out:
 	spin_unlock_irqrestore(&djrcv_dev->lock, flags);
 
 	return true;
-- 
2.1.0
