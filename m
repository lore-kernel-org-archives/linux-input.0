From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] HID: logitech-dj: Combine substrings for seven messages
Date: Mon, 5 Feb 2018 22:28:46 +0100
Message-ID: <c2521760-689d-772e-1e3c-401e51c8ca60@users.sourceforge.net>
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:63981 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeBEV24 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Feb 2018 16:28:56 -0500
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:06:20 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 0da00d256ca7..f1496c6303ce 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -463,16 +463,17 @@ static void delayedwork_callback(struct work_struct *work)
 				sizeof(struct dj_report));
 
 	if (count != sizeof(struct dj_report)) {
-		dev_err(&djrcv_dev->hdev->dev, "%s: workitem triggered without "
-			"notifications available\n", __func__);
+		dev_err(&djrcv_dev->hdev->dev,
+			"%s: workitem triggered without notifications available\n",
+			__func__);
 		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
 		return;
 	}
 
 	if (!kfifo_is_empty(&djrcv_dev->notif_fifo)) {
 		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was "
-				"already queued\n", __func__);
+			dbg_hid("%s: did not schedule the work item, was already queued\n",
+				__func__);
 		}
 	}
 
@@ -502,8 +503,8 @@ static void delayedwork_callback(struct work_struct *work)
 			break;
 		}
 		dev_err(&djrcv_dev->hdev->dev,
-			"%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+			"%s:logi_dj_recv_query_paired_devices error:%d\n",
+			__func__, retval);
 		}
 		dbg_hid("%s: unexpected report type\n", __func__);
 	}
@@ -517,8 +518,8 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
 	kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
 
 	if (schedule_work(&djrcv_dev->work) == 0) {
-		dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
+		dbg_hid("%s: did not schedule the work item, was already queued\n",
+			__func__);
 	}
 }
 
@@ -541,8 +542,7 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 					     HID_INPUT_REPORT,
 					     reportbuffer,
 					     hid_reportid_size_map[i], 1)) {
-				dbg_hid("hid_input_report error sending null "
-					"report\n");
+				dbg_hid("hid_input_report error sending null report\n");
 			}
 		}
 	}
@@ -770,8 +770,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	}
 
 	if (djdev->reports_supported & STD_MOUSE) {
-		dbg_hid("%s: sending a mouse descriptor, reports_supported: "
-			"%x\n", __func__, djdev->reports_supported);
+		dbg_hid("%s: sending a mouse descriptor, reports_supported: %x\n",
+			__func__, djdev->reports_supported);
 		rdcat(rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
 	}
 
@@ -1068,8 +1068,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
-		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+		dev_err(&hdev->dev,
+			"%s:logi_dj_recv_query_paired_devices error:%d\n",
+			__func__, retval);
 		goto logi_dj_recv_query_paired_devices_failed;
 	}
 
-- 
2.16.1

