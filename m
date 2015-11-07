From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH 1/2] hid: sony: Refactor output report sending functions
Date: Sat,  7 Nov 2015 10:12:09 -0500
Message-ID: <1446909130-9168-2-git-send-email-frank.praznik@gmail.com>
References: <1446909130-9168-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33366 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbKGPMw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Nov 2015 10:12:52 -0500
Received: by igvi2 with SMTP id i2so50941282igv.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2015 07:12:52 -0800 (PST)
In-Reply-To: <1446909130-9168-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@gmail.com>

Refactor output report sending functions to allow for the sending of
output reports without enqueing a work item.  Output reports for any device
can now be sent by calling the sony_send_output_report function which will
automatically dispatch the request to the appropriate output function.  The
individual state worker functions have been replaced with a universal
sony_state_worker function which calls sony_send_output_report.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 661f94f..b84b2ce 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1782,7 +1782,7 @@ error_leds:
 	return ret;
 }
 
-static void sixaxis_state_worker(struct work_struct *work)
+static void sixaxis_send_output_report(struct sony_sc *sc)
 {
 	static const union sixaxis_output_report_01 default_report = {
 		.buf = {
@@ -1796,7 +1796,6 @@ static void sixaxis_state_worker(struct work_struct *work)
 			0x00, 0x00, 0x00, 0x00, 0x00
 		}
 	};
-	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct sixaxis_output_report *report =
 		(struct sixaxis_output_report *)sc->output_report_dmabuf;
 	int n;
@@ -1839,9 +1838,8 @@ static void sixaxis_state_worker(struct work_struct *work)
 			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
-static void dualshock4_state_worker(struct work_struct *work)
+static void dualshock4_send_output_report(struct sony_sc *sc)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
 	__u8 *buf = sc->output_report_dmabuf;
 	int offset;
@@ -1886,9 +1884,8 @@ static void dualshock4_state_worker(struct work_struct *work)
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
-static void motion_state_worker(struct work_struct *work)
+static void motion_send_output_report(struct sony_sc *sc)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
 	struct motion_output_report_02 *report =
 		(struct motion_output_report_02 *)sc->output_report_dmabuf;
@@ -1907,6 +1904,23 @@ static void motion_state_worker(struct work_struct *work)
 	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
 }
 
+static void sony_send_output_report(struct sony_sc *sc)
+{
+	if (sc->quirks & DUALSHOCK4_CONTROLLER)
+		dualshock4_send_output_report(sc);
+	else if ((sc->quirks & SIXAXIS_CONTROLLER) ||
+			(sc->quirks & NAVIGATION_CONTROLLER))
+		sixaxis_send_output_report(sc);
+	else if (sc->quirks & MOTION_CONTROLLER)
+		motion_send_output_report(sc);
+}
+
+static void sony_state_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	sony_send_output_report(sc);
+}
+
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
 	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
@@ -2234,11 +2248,10 @@ static void sony_release_device_id(struct sony_sc *sc)
 	}
 }
 
-static inline void sony_init_work(struct sony_sc *sc,
-					void (*worker)(struct work_struct *))
+static inline void sony_init_work(struct sony_sc *sc)
 {
 	if (!sc->worker_initialized)
-		INIT_WORK(&sc->state_worker, worker);
+		INIT_WORK(&sc->state_worker, sony_state_worker);
 
 	sc->worker_initialized = 1;
 }
@@ -2312,7 +2325,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 		ret = sixaxis_set_operational_usb(hdev);
-		sony_init_work(sc, sixaxis_state_worker);
+		sony_init_work(sc);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
 			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
 		/*
@@ -2321,7 +2334,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 */
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		ret = sixaxis_set_operational_bt(hdev);
-		sony_init_work(sc, sixaxis_state_worker);
+		sony_init_work(sc);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 			/*
@@ -2336,9 +2349,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			}
 		}
 
-		sony_init_work(sc, dualshock4_state_worker);
+		sony_init_work(sc);
 	} else if (sc->quirks & MOTION_CONTROLLER) {
-		sony_init_work(sc, motion_state_worker);
+		sony_init_work(sc);
 	} else {
 		ret = 0;
 	}
-- 
2.4.3

