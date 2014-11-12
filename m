From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3] hid: sony: Use kernel allocated buffers for HID reports
Date: Wed, 12 Nov 2014 14:10:09 -0500
Message-ID: <1415819409-4408-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:32102 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753151AbaKLTKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 14:10:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, ao2@ao2.it, Frank Praznik <frank.praznik@oh.rr.com>

Replace stack buffers with kernel allocated buffers for sending
and receiving HID reports to prevent issues with DMA transfers
on certain hardware.

Output report buffers are allocated at initialization time to avoid
excessive calls to kmalloc and kfree.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 The original reporter confirms that this fixes the bug reported in
 https://bugzilla.kernel.org/show_bug.cgi?id=87991

 v2 fixes a sizeof(pointer) mistake and corrects some cosmetic issues
 (spacing and #defines instead of magic constants).

 v3 uses hex notation for the report size definitions instead of decimal for
 consistency since hex notation is used for the report numbers in the rest of
 the driver.

 drivers/hid/hid-sony.c | 147 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 113 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bc4269e..b6e6102 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -798,6 +798,12 @@ union sixaxis_output_report_01 {
 	__u8 buf[36];
 };
 
+#define DS4_REPORT_0x02_SIZE 37
+#define DS4_REPORT_0x05_SIZE 32
+#define DS4_REPORT_0x11_SIZE 78
+#define DS4_REPORT_0x81_SIZE 7
+#define SIXAXIS_REPORT_0xF2_SIZE 18
+
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
@@ -811,6 +817,7 @@ struct sony_sc {
 	struct work_struct state_worker;
 	struct power_supply battery;
 	int device_id;
+	__u8 *output_report_dmabuf;
 
 #ifdef CONFIG_SONY_FF
 	__u8 left;
@@ -1142,9 +1149,20 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 
 static int sixaxis_set_operational_bt(struct hid_device *hdev)
 {
-	unsigned char buf[] = { 0xf4,  0x42, 0x03, 0x00, 0x00 };
-	return hid_hw_raw_request(hdev, buf[0], buf, sizeof(buf),
+	static const __u8 report[] = { 0xf4, 0x42, 0x03, 0x00, 0x00 };
+	__u8 *buf;
+	int ret;
+
+	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(report),
 				  HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(buf);
+
+	return ret;
 }
 
 /*
@@ -1153,10 +1171,19 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
  */
 static int dualshock4_set_operational_bt(struct hid_device *hdev)
 {
-	__u8 buf[37] = { 0 };
+	__u8 *buf;
+	int ret;
 
-	return hid_hw_raw_request(hdev, 0x02, buf, sizeof(buf),
+	buf = kmalloc(DS4_REPORT_0x02_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, 0x02, buf, DS4_REPORT_0x02_SIZE,
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+	kfree(buf);
+
+	return ret;
 }
 
 static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
@@ -1471,9 +1498,7 @@ error_leds:
 
 static void sixaxis_state_worker(struct work_struct *work)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
-	int n;
-	union sixaxis_output_report_01 report = {
+	static const union sixaxis_output_report_01 default_report = {
 		.buf = {
 			0x01,
 			0x00, 0xff, 0x00, 0xff, 0x00,
@@ -1485,20 +1510,27 @@ static void sixaxis_state_worker(struct work_struct *work)
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
@@ -1511,28 +1543,30 @@ static void sixaxis_state_worker(struct work_struct *work)
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
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct hid_device *hdev = sc->hdev;
+	__u8 *buf = sc->output_report_dmabuf;
 	int offset;
 
-	__u8 buf[78] = { 0 };
-
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		memset(buf, 0, DS4_REPORT_0x05_SIZE);
 		buf[0] = 0x05;
 		buf[1] = 0xFF;
 		offset = 4;
 	} else {
+		memset(buf, 0, DS4_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
 		buf[1] = 0xB0;
 		buf[3] = 0x0F;
@@ -1560,12 +1594,33 @@ static void dualshock4_state_worker(struct work_struct *work)
 	buf[offset++] = sc->led_delay_off[3];
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
-		hid_hw_output_report(hdev, buf, 32);
+		hid_hw_output_report(hdev, buf, DS4_REPORT_0x05_SIZE);
 	else
-		hid_hw_raw_request(hdev, 0x11, buf, 78,
+		hid_hw_raw_request(hdev, 0x11, buf, DS4_REPORT_0x11_SIZE,
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static int sony_allocate_output_report(struct sony_sc *sc)
+{
+	if (sc->quirks & SIXAXIS_CONTROLLER)
+		sc->output_report_dmabuf =
+			kmalloc(sizeof(union sixaxis_output_report_01),
+				GFP_KERNEL);
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
+		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x11_SIZE,
+						GFP_KERNEL);
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x05_SIZE,
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
@@ -1754,6 +1809,7 @@ static int sony_get_bt_devaddr(struct sony_sc *sc)
 
 static int sony_check_add(struct sony_sc *sc)
 {
+	__u8 *buf = NULL;
 	int n, ret;
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
@@ -1769,36 +1825,44 @@ static int sony_check_add(struct sony_sc *sc)
 			return 0;
 		}
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		__u8 buf[7];
+		buf = kmalloc(DS4_REPORT_0x81_SIZE, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 
 		/*
 		 * The MAC address of a DS4 controller connected via USB can be
 		 * retrieved with feature report 0x81. The address begins at
 		 * offset 1.
 		 */
-		ret = hid_hw_raw_request(sc->hdev, 0x81, buf, sizeof(buf),
-				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+		ret = hid_hw_raw_request(sc->hdev, 0x81, buf,
+				DS4_REPORT_0x81_SIZE, HID_FEATURE_REPORT,
+				HID_REQ_GET_REPORT);
 
-		if (ret != 7) {
+		if (ret != DS4_REPORT_0x81_SIZE) {
 			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
-			return ret < 0 ? ret : -EINVAL;
+			ret = ret < 0 ? ret : -EINVAL;
+			goto out_free;
 		}
 
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
-		__u8 buf[18];
+		buf = kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 
 		/*
 		 * The MAC address of a Sixaxis controller connected via USB can
 		 * be retrieved with feature report 0xf2. The address begins at
 		 * offset 4.
 		 */
-		ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, sizeof(buf),
-				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+		ret = hid_hw_raw_request(sc->hdev, 0xf2, buf,
+				SIXAXIS_REPORT_0xF2_SIZE, HID_FEATURE_REPORT,
+				HID_REQ_GET_REPORT);
 
-		if (ret != 18) {
+		if (ret != SIXAXIS_REPORT_0xF2_SIZE) {
 			hid_err(sc->hdev, "failed to retrieve feature report 0xf2 with the Sixaxis MAC address\n");
-			return ret < 0 ? ret : -EINVAL;
+			ret = ret < 0 ? ret : -EINVAL;
+			goto out_free;
 		}
 
 		/*
@@ -1811,7 +1875,13 @@ static int sony_check_add(struct sony_sc *sc)
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
@@ -1895,6 +1965,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -1984,6 +2060,7 @@ err_stop:
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
 	sony_cancel_work_sync(sc);
+	kfree(sc->output_report_dmabuf);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
 	hid_hw_stop(hdev);
@@ -2004,6 +2081,8 @@ static void sony_remove(struct hid_device *hdev)
 
 	sony_cancel_work_sync(sc);
 
+	kfree(sc->output_report_dmabuf);
+
 	sony_remove_dev_list(sc);
 
 	sony_release_device_id(sc);
-- 
2.1.0

