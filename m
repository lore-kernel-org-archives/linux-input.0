From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 4/8] HID: sony: Use a struct for the Sixaxis output report.
Date: Thu,  6 Mar 2014 17:32:52 -0500
Message-ID: <1394145176-24174-5-git-send-email-frank.praznik@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:4607 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752113AbaCFWdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:33:07 -0500
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Use a struct for the Sixaxis output report that uses named members to set the
report fields.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 66 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 3df3306..5e9bb57 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -717,6 +717,36 @@ static enum power_supply_property sony_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 };
 
+struct sixaxis_led {
+	__u8 time_enabled; /* the total time the led is active (0xff means forever) */
+	__u8 duty_length;  /* how long a cycle is in deciseconds (0 means "really fast") */
+	__u8 enabled;
+	__u8 duty_off; /* % of duty_length the led is off (0xff means 100%) */
+	__u8 duty_on;  /* % of duty_length the led is on (0xff mean 100%) */
+} __packed;
+
+struct sixaxis_rumble {
+	__u8 padding;
+	__u8 right_duration; /* Right motor duration (0xff means forever) */
+	__u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
+	__u8 left_duration; /* Left motor duration (0xff means forever) */
+	__u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
+} __packed;
+
+struct sixaxis_output_report {
+	__u8 report_id;
+	struct sixaxis_rumble rumble;
+	__u8 padding[4];
+	__u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
+	struct sixaxis_led led[4]; /* LEDx at (4 - x), add a macro? */
+	struct sixaxis_led _reserved; /* LED5, not actually soldered */
+} __packed;
+
+union sixaxis_output_report_01 {
+	struct sixaxis_output_report data;
+	__u8 buf[36];
+};
+
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
 
@@ -1244,29 +1274,31 @@ error_leds:
 static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
-	unsigned char buf[] = {
-		0x01,
-		0x00, 0xff, 0x00, 0xff, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0x00, 0x00, 0x00, 0x00, 0x00
+	union sixaxis_output_report_01 report = {
+		.buf = {
+			0x01,
+			0x00, 0xff, 0x00, 0xff, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00,
+			0xff, 0x27, 0x10, 0x00, 0x32,
+			0xff, 0x27, 0x10, 0x00, 0x32,
+			0xff, 0x27, 0x10, 0x00, 0x32,
+			0xff, 0x27, 0x10, 0x00, 0x32,
+			0x00, 0x00, 0x00, 0x00, 0x00
+		}
 	};
 
 #ifdef CONFIG_SONY_FF
-	buf[3] = sc->right ? 1 : 0;
-	buf[5] = sc->left;
+	report.data.rumble.right_motor_on = sc->right ? 1 : 0;
+	report.data.rumble.left_motor_force = sc->left;
 #endif
 
-	buf[10] |= sc->led_state[0] << 1;
-	buf[10] |= sc->led_state[1] << 2;
-	buf[10] |= sc->led_state[2] << 3;
-	buf[10] |= sc->led_state[3] << 4;
+	report.data.leds_bitmap |= sc->led_state[0] << 1;
+	report.data.leds_bitmap |= sc->led_state[1] << 2;
+	report.data.leds_bitmap |= sc->led_state[2] << 3;
+	report.data.leds_bitmap |= sc->led_state[3] << 4;
 
-	hid_hw_raw_request(sc->hdev, 0x01, buf, sizeof(buf), HID_OUTPUT_REPORT,
-			HID_REQ_SET_REPORT);
+	hid_hw_raw_request(sc->hdev, report.data.report_id, report.buf,
+			sizeof(report), HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
 static void dualshock4_state_worker(struct work_struct *work)
-- 
1.8.5.3

