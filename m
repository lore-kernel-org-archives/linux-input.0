From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: [PATCH 3/3] Revert "HID: Fix logitech-dj: missing Unifying device issue"
Date: Mon, 18 Feb 2013 09:20:23 -0800
Message-ID: <1361208023-11500-4-git-send-email-andrew-vger@gizmolabs.org>
References: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
 <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:45318 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab3BRRUh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 12:20:37 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2562294dak.5
        for <linux-input@vger.kernel.org>; Mon, 18 Feb 2013 09:20:36 -0800 (PST)
In-Reply-To: <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Andrew de los Reyes <adlr@chromium.org>

From: Andrew de los Reyes <adlr@chromium.org>

This reverts commit 596264082f10dd4a567c43d4526b2f54ac5520bc.

The reverted commit was a workaround needed when drivers became unable
to communicate with devices during probe(). Now that such
communication is possible, the workaround is not needed.

Change-Id: I75e27afbd1acfcb2fea2a7a645b4fcec3e31c417
Signed-off-by: Andrew de los Reyes <adlr@chromium.org>
---
 drivers/hid/hid-logitech-dj.c | 45 -------------------------------------------
 drivers/hid/hid-logitech-dj.h |  1 -
 2 files changed, 46 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index bf647ef..199b78c 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -193,7 +193,6 @@ static struct hid_ll_driver logi_dj_ll_driver;
 static int logi_dj_output_hidraw_report(struct hid_device *hid, u8 * buf,
 					size_t count,
 					unsigned char report_type);
-static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev);
 
 static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
 						struct dj_report *dj_report)
@@ -234,7 +233,6 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	if (dj_report->report_params[DEVICE_PAIRED_PARAM_SPFUNCTION] &
 	    SPFUNCTION_DEVICE_LIST_EMPTY) {
 		dbg_hid("%s: device list is empty\n", __func__);
-		djrcv_dev->querying_devices = false;
 		return;
 	}
 
@@ -245,12 +243,6 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 		return;
 	}
 
-	if (djrcv_dev->paired_dj_devices[dj_report->device_index]) {
-		/* The device is already known. No need to reallocate it. */
-		dbg_hid("%s: device is already known\n", __func__);
-		return;
-	}
-
 	dj_hiddev = hid_allocate_device();
 	if (IS_ERR(dj_hiddev)) {
 		dev_err(&djrcv_hdev->dev, "%s: hid_allocate_device failed\n",
@@ -314,7 +306,6 @@ static void delayedwork_callback(struct work_struct *work)
 	struct dj_report dj_report;
 	unsigned long flags;
 	int count;
-	int retval;
 
 	dbg_hid("%s\n", __func__);
 
@@ -347,25 +338,6 @@ static void delayedwork_callback(struct work_struct *work)
 		logi_dj_recv_destroy_djhid_device(djrcv_dev, &dj_report);
 		break;
 	default:
-	/* A normal report (i. e. not belonging to a pair/unpair notification)
-	 * arriving here, means that the report arrived but we did not have a
-	 * paired dj_device associated to the report's device_index, this
-	 * means that the original "device paired" notification corresponding
-	 * to this dj_device never arrived to this driver. The reason is that
-	 * hid-core discards all packets coming from a device while probe() is
-	 * executing. */
-	if (!djrcv_dev->paired_dj_devices[dj_report.device_index]) {
-		/* ok, we don't know the device, just re-ask the
-		 * receiver for the list of connected devices. */
-		retval = logi_dj_recv_query_paired_devices(djrcv_dev);
-		if (!retval) {
-			/* everything went fine, so just leave */
-			break;
-		}
-		dev_err(&djrcv_dev->hdev->dev,
-			"%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
-		}
 		dbg_hid("%s: unexpected report type\n", __func__);
 	}
 }
@@ -396,12 +368,6 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 	if (!djdev) {
 		dbg_hid("djrcv_dev->paired_dj_devices[dj_report->device_index]"
 			" is NULL, index %d\n", dj_report->device_index);
-		kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
-
-		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
-		}
 		return;
 	}
 
@@ -432,12 +398,6 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 	if (dj_device == NULL) {
 		dbg_hid("djrcv_dev->paired_dj_devices[dj_report->device_index]"
 			" is NULL, index %d\n", dj_report->device_index);
-		kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
-
-		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
-		}
 		return;
 	}
 
@@ -479,10 +439,6 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	struct dj_report *dj_report;
 	int retval;
 
-	/* no need to protect djrcv_dev->querying_devices */
-	if (djrcv_dev->querying_devices)
-		return 0;
-
 	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
@@ -494,7 +450,6 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	return retval;
 }
 
-
 static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 					  unsigned timeout)
 {
diff --git a/drivers/hid/hid-logitech-dj.h b/drivers/hid/hid-logitech-dj.h
index 4a40003..fd28a5e 100644
--- a/drivers/hid/hid-logitech-dj.h
+++ b/drivers/hid/hid-logitech-dj.h
@@ -101,7 +101,6 @@ struct dj_receiver_dev {
 	struct work_struct work;
 	struct kfifo notif_fifo;
 	spinlock_t lock;
-	bool querying_devices;
 };
 
 struct dj_device {
-- 
1.8.1.3

