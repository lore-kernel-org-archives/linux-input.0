From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/7] HID: sony: Fix race condition in sony_probe
Date: Fri,  7 Oct 2016 12:39:34 -0700
Message-ID: <1475869180-26757-2-git-send-email-roderick@gaikai.com>
References: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38479 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbcJGTkN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 15:40:13 -0400
Received: by mail-it0-f42.google.com with SMTP id o19so26658363ito.1
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 12:40:12 -0700 (PDT)
In-Reply-To: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Early on the sony_probe function calls hid_hw_start to start the hardware.
Afterwards it issues some hardware requests, initializes other functionality
like Force Feedback, power classes and others. However by the time
hid_hw_start returns, the device nodes have already been created, which leads
to a race condition by user space applications which may detect the device
prior to completion of initialization. We have observed this problem many
times, this patch fixes the problem.

This patch moves most of sony_probe to sony_input_configured, which is called
prior to device registration. This fixes the race condition and the same
approach is used in other HID drivers.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 117 ++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b0bb99a..afa8219 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1387,28 +1387,6 @@ static int sony_register_touchpad(struct hid_input *hi, int touch_count,
 	return 0;
 }
 
-static int sony_input_configured(struct hid_device *hdev,
-					struct hid_input *hidinput)
-{
-	struct sony_sc *sc = hid_get_drvdata(hdev);
-	int ret;
-
-	/*
-	 * The Dualshock 4 touchpad supports 2 touches and has a
-	 * resolution of 1920x942 (44.86 dots/mm).
-	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER) {
-		ret = sony_register_touchpad(hidinput, 2, 1920, 942);
-		if (ret) {
-			hid_err(sc->hdev,
-				"Unable to initialize multi-touch slots: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
 
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
@@ -2329,45 +2307,12 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 		cancel_work_sync(&sc->state_worker);
 }
 
-static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
+static int sony_input_configured(struct hid_device *hdev,
+					struct hid_input *hidinput)
 {
-	int ret;
+	struct sony_sc *sc = hid_get_drvdata(hdev);
 	int append_dev_id;
-	unsigned long quirks = id->driver_data;
-	struct sony_sc *sc;
-	unsigned int connect_mask = HID_CONNECT_DEFAULT;
-
-	if (!strcmp(hdev->name, "FutureMax Dance Mat"))
-		quirks |= FUTUREMAX_DANCE_MAT;
-
-	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
-	if (sc == NULL) {
-		hid_err(hdev, "can't alloc sony descriptor\n");
-		return -ENOMEM;
-	}
-
-	spin_lock_init(&sc->lock);
-
-	sc->quirks = quirks;
-	hid_set_drvdata(hdev, sc);
-	sc->hdev = hdev;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		return ret;
-	}
-
-	if (sc->quirks & VAIO_RDESC_CONSTANT)
-		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
-	else if (sc->quirks & SIXAXIS_CONTROLLER)
-		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
-
-	ret = hid_hw_start(hdev, connect_mask);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		return ret;
-	}
+	int ret;
 
 	ret = sony_set_device_id(sc);
 	if (ret < 0) {
@@ -2427,6 +2372,18 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			}
 		}
 
+		/*
+		 * The Dualshock 4 touchpad supports 2 touches and has a
+		 * resolution of 1920x942 (44.86 dots/mm).
+		 */
+		ret = sony_register_touchpad(hidinput, 2, 1920, 942);
+		if (ret) {
+			hid_err(sc->hdev,
+			"Unable to initialize multi-touch slots: %d\n",
+			ret);
+			return ret;
+		}
+
 		sony_init_output_report(sc, dualshock4_send_output_report);
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
@@ -2482,6 +2439,48 @@ err_stop:
 	return ret;
 }
 
+static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	unsigned long quirks = id->driver_data;
+	struct sony_sc *sc;
+	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+
+	if (!strcmp(hdev->name, "FutureMax Dance Mat"))
+		quirks |= FUTUREMAX_DANCE_MAT;
+
+	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
+	if (sc == NULL) {
+		hid_err(hdev, "can't alloc sony descriptor\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&sc->lock);
+
+	sc->quirks = quirks;
+	hid_set_drvdata(hdev, sc);
+	sc->hdev = hdev;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	if (sc->quirks & VAIO_RDESC_CONSTANT)
+		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
+	else if (sc->quirks & SIXAXIS_CONTROLLER)
+		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
+
+	ret = hid_hw_start(hdev, connect_mask);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
-- 
2.7.4

