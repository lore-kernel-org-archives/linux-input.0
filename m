From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Use kernel allocated buffers for HID reports
Date: Tue, 11 Nov 2014 13:01:53 -0500
Message-ID: <1415728913-2679-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:34046 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750859AbaKKSFR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2014 13:05:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, hector@marcansoft.com, Frank Praznik <frank.praznik@oh.rr.com>

Replace stack buffers with kernel allocated buffers when sending
and receiving HID reports to prevent issues with DMA transfers
on certain hardware.

Output report buffers are allocated at initialization time to avoid
excessive kmalloc and kfree calls.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 I'm CC-ing the original bug reporter to see if he can test this patch
 on whatever platform was giving him trouble as I can't replicate the
 reported error on my end.

 drivers/hid/hid-sony.c | 135 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 105 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bc4269e..28f2849 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -798,6 +798,9 @@ union sixaxis_output_report_01 {
 	__u8 buf[36];
 };
 
+#define DS4_REPORT5_SIZE 32
+#define DS4_REPORT17_SIZE 78
+
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
@@ -811,6 +814,7 @@ struct sony_sc {
 	struct work_struct state_worker;
 	struct power_supply battery;
 	int device_id;
+	__u8 *output_report_dmabuf;
 
 #ifdef CONFIG_SONY_FF
 	__u8 left;
@@ -1142,9 +1146,19 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 
 static int sixaxis_set_operational_bt(struct hid_device *hdev)
 {
-	unsigned char buf[] = { 0xf4,  0x42, 0x03, 0x00, 0x00 };
-	return hid_hw_raw_request(hdev, buf[0], buf, sizeof(buf),
+	static const __u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
+	__u8 *buf = kmemdup(report, sizeof(report), GFP_KERNEL);
+	int ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(buf),
 				  HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(buf);
+
+	return ret;
 }
 
 /*
@@ -1153,10 +1167,18 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
  */
 static int dualshock4_set_operational_bt(struct hid_device *hdev)
 {
-	__u8 buf[37] = { 0 };
+	__u8 *buf = kmalloc(37, GFP_KERNEL);
+	int ret;
 
-	return hid_hw_raw_request(hdev, 0x02, buf, sizeof(buf),
-				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, 0x02, buf, 37, HID_FEATURE_REPORT,
+				HID_REQ_GET_REPORT);
+
+	kfree(buf);
+
+	return ret;
 }
 
 static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
@@ -1471,9 +1493,7 @@ error_leds:
 
 static void sixaxis_state_worker(struct work_struct *work)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
-	int n;
-	union sixaxis_output_report_01 report = {
+	static const union sixaxis_output_report_01 default_report = {
 		.buf = {
 			0x01,
 			0x00, 0xff, 0x00, 0xff, 0x00,
@@ -1485,20 +1505,27 @@ static void sixaxis_state_worker(struct work_struct *work)
 			0x00, 0x00, 0x00, 0x00, 0x00
 		}
 	};
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	struct sixaxis_output_report *report =
+		(struct sixaxis_output_report *)sc->output_report_dmabuf;
+	int n;
+
+	/* Initialize the report with default values */
+	memcpy(report, &default_report, sizeof(struct sixaxis_output_report));
 
 #ifdef CONFIG_SONY_FF
-	report.data.rumble.right_motor_on = sc->right ? 1 : 0;
-	report.data.rumble.left_motor_force = sc->left;
+	report->rumble.right_motor_on = sc->right ? 1 : 0;
+	report->rumble.left_motor_force = sc->left;
 #endif
 
-	report.data.leds_bitmap |= sc->led_state[0] << 1;
-	report.data.leds_bitmap |= sc->led_state[1] << 2;
-	report.data.leds_bitmap |= sc->led_state[2] << 3;
-	report.data.leds_bitmap |= sc->led_state[3] << 4;
+	report->leds_bitmap |= sc->led_state[0] << 1;
+	report->leds_bitmap |= sc->led_state[1] << 2;
+	report->leds_bitmap |= sc->led_state[2] << 3;
+	report->leds_bitmap |= sc->led_state[3] << 4;
 
 	/* Set flag for all leds off, required for 3rd party INTEC controller */
-	if ((report.data.leds_bitmap & 0x1E) == 0)
-		report.data.leds_bitmap |= 0x20;
+	if ((report->leds_bitmap & 0x1E) == 0)
+		report->leds_bitmap |= 0x20;
 
 	/*
 	 * The LEDs in the report are indexed in reverse order to their
@@ -1511,13 +1538,14 @@ static void sixaxis_state_worker(struct work_struct *work)
 	 */
 	for (n = 0; n < 4; n++) {
 		if (sc->led_delay_on[n] || sc->led_delay_off[n]) {
-			report.data.led[3 - n].duty_off = sc->led_delay_off[n];
-			report.data.led[3 - n].duty_on = sc->led_delay_on[n];
+			report->led[3 - n].duty_off = sc->led_delay_off[n];
+			report->led[3 - n].duty_on = sc->led_delay_on[n];
 		}
 	}
 
-	hid_hw_raw_request(sc->hdev, report.data.report_id, report.buf,
-			sizeof(report), HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	hid_hw_raw_request(sc->hdev, report->report_id, (__u8 *)report,
+			sizeof(struct sixaxis_output_report),
+			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
 static void dualshock4_state_worker(struct work_struct *work)
@@ -1526,13 +1554,15 @@ static void dualshock4_state_worker(struct work_struct *work)
 	struct hid_device *hdev = sc->hdev;
 	int offset;
 
-	__u8 buf[78] = { 0 };
+	__u8 *buf = sc->output_report_dmabuf;
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		memset(buf, 0, DS4_REPORT5_SIZE);
 		buf[0] = 0x05;
 		buf[1] = 0xFF;
 		offset = 4;
 	} else {
+		memset(buf, 0, DS4_REPORT17_SIZE);
 		buf[0] = 0x11;
 		buf[1] = 0xB0;
 		buf[3] = 0x0F;
@@ -1560,12 +1590,33 @@ static void dualshock4_state_worker(struct work_struct *work)
 	buf[offset++] = sc->led_delay_off[3];
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
-		hid_hw_output_report(hdev, buf, 32);
+		hid_hw_output_report(hdev, buf, DS4_REPORT5_SIZE);
 	else
-		hid_hw_raw_request(hdev, 0x11, buf, 78,
+		hid_hw_raw_request(hdev, 0x11, buf, DS4_REPORT17_SIZE,
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static int sony_allocate_output_report(struct sony_sc *sc)
+{
+	if (sc->quirks & SIXAXIS_CONTROLLER)
+		sc->output_report_dmabuf =
+			kmalloc(sizeof(union sixaxis_output_report_01),
+				GFP_KERNEL);
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
+		sc->output_report_dmabuf = kmalloc(DS4_REPORT17_SIZE,
+						GFP_KERNEL);
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+		sc->output_report_dmabuf = kmalloc(DS4_REPORT5_SIZE,
+						GFP_KERNEL);
+	else
+		return 0;
+
+	if (!sc->output_report_dmabuf)
+		return -ENOMEM;
+
+	return 0;
+}
+
 #ifdef CONFIG_SONY_FF
 static int sony_play_effect(struct input_dev *dev, void *data,
 			    struct ff_effect *effect)
@@ -1754,6 +1805,7 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
 
 static int sony_check_add(struct sony_sc *sc)
 {
+	__u8 *buf = NULL;
 	int n, ret;
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
@@ -1769,36 +1821,44 @@ static int sony_check_add(struct sony_sc *sc)
 			return 0;
 		}
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		__u8 buf[7];
+		buf = kmalloc(7, GFP_KERNEL);
+
+		if (!buf)
+			return -ENOMEM;
 
 		/*
 		 * The MAC address of a DS4 controller connected via USB can be
 		 * retrieved with feature report 0x81. The address begins at
 		 * offset 1.
 		 */
-		ret = hid_hw_raw_request(sc->hdev, 0x81, buf, sizeof(buf),
+		ret = hid_hw_raw_request(sc->hdev, 0x81, buf, 7,
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 		if (ret != 7) {
 			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
-			return ret < 0 ? ret : -EINVAL;
+			ret = ret < 0 ? ret : -EINVAL;
+			goto out_free;
 		}
 
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
-		__u8 buf[18];
+		buf = kmalloc(18, GFP_KERNEL);
+
+		if (!buf)
+			return -ENOMEM;
 
 		/*
 		 * The MAC address of a Sixaxis controller connected via USB can
 		 * be retrieved with feature report 0xf2. The address begins at
 		 * offset 4.
 		 */
-		ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, sizeof(buf),
+		ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, 18,
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 		if (ret != 18) {
 			hid_err(sc->hdev, "failed to retrieve feature report 0xf2 with the Sixaxis MAC address\n");
-			return ret < 0 ? ret : -EINVAL;
+			ret = ret < 0 ? ret : -EINVAL;
+			goto out_free;
 		}
 
 		/*
@@ -1811,7 +1871,13 @@ static int sony_check_add(struct sony_sc *sc)
 		return 0;
 	}
 
-	return sony_check_add_dev_list(sc);
+	ret = sony_check_add_dev_list(sc);
+
+out_free:
+
+	kfree(buf);
+
+	return ret;
 }
 
 static int sony_set_device_id(struct sony_sc *sc)
@@ -1895,6 +1961,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	ret = sony_allocate_output_report(sc);
+	if (ret < 0) {
+		hid_err(hdev, "failed to allocate the output report buffer\n");
+		goto err_stop;
+	}
+
 	ret = sony_set_device_id(sc);
 	if (ret < 0) {
 		hid_err(hdev, "failed to allocate the device id\n");
@@ -1984,6 +2056,7 @@ err_stop:
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
 	sony_cancel_work_sync(sc);
+	kfree(sc->output_report_dmabuf);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
 	hid_hw_stop(hdev);
@@ -2004,6 +2077,8 @@ static void sony_remove(struct hid_device *hdev)
 
 	sony_cancel_work_sync(sc);
 
+	kfree(sc->output_report_dmabuf);
+
 	sony_remove_dev_list(sc);
 
 	sony_release_device_id(sc);
-- 
2.1.0

