From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 7/8] HID: sony: Initialize the controller LEDs with the device ID value
Date: Thu,  6 Mar 2014 17:32:55 -0500
Message-ID: <1394145176-24174-8-git-send-email-frank.praznik@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:13302 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751568AbaCFWkj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:40:39 -0500
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Use the device ID to initialize the Sixaxis and DualShock 4 controller LEDs to
default values.  The number or color of the controller is set relative to other
connected Sony controllers.

Set the LED class brightness values to the initial values and add the new led to
the array before calling led_classdev_register so that the correct brightness value
shows up in the LED sysfs entry.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v2 uses the id assigned by the IDA allocator to set the default values.

 drivers/hid/hid-sony.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 13af58c..6de42b4 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1081,6 +1081,52 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 }
 
+static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+{
+	static const __u8 sixaxis_leds[10][4] = {
+				{ 0x01, 0x00, 0x00, 0x00 },
+				{ 0x00, 0x01, 0x00, 0x00 },
+				{ 0x00, 0x00, 0x01, 0x00 },
+				{ 0x00, 0x00, 0x00, 0x01 },
+				{ 0x01, 0x00, 0x00, 0x01 },
+				{ 0x00, 0x01, 0x00, 0x01 },
+				{ 0x00, 0x00, 0x01, 0x01 },
+				{ 0x01, 0x00, 0x01, 0x01 },
+				{ 0x00, 0x01, 0x01, 0x01 },
+				{ 0x01, 0x01, 0x01, 0x01 }
+	};
+
+	BUG_ON(MAX_LEDS < ARRAY_SIZE(sixaxis_leds[0]));
+
+	if (id < 0)
+		return;
+
+	id %= 10;
+	memcpy(values, sixaxis_leds[id], sizeof(sixaxis_leds[id]));
+}
+
+static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+{
+	/* The first 4 color/index entries match what the PS4 assigns */
+	static const __u8 color_code[7][3] = {
+			/* Blue   */	{ 0x00, 0x00, 0x01 },
+			/* Red	  */	{ 0x01, 0x00, 0x00 },
+			/* Green  */	{ 0x00, 0x01, 0x00 },
+			/* Pink   */	{ 0x02, 0x00, 0x01 },
+			/* Orange */	{ 0x02, 0x01, 0x00 },
+			/* Teal   */	{ 0x00, 0x01, 0x01 },
+			/* White  */	{ 0x01, 0x01, 0x01 }
+	};
+
+	BUG_ON(MAX_LEDS < ARRAY_SIZE(color_code[0]));
+
+	if (id < 0)
+		return;
+
+	id %= 7;
+	memcpy(values, color_code[id], sizeof(color_code[id]));
+}
+
 static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 {
 	struct list_head *report_list =
@@ -1194,7 +1240,7 @@ static int sony_leds_init(struct sony_sc *sc)
 	size_t name_len;
 	const char *name_fmt;
 	static const char * const color_str[] = { "red", "green", "blue" };
-	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
+	__u8 initial_values[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
@@ -1208,12 +1254,14 @@ static int sony_leds_init(struct sony_sc *sc)
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		dualshock4_set_leds_from_id(sc->device_id, initial_values);
 		sc->led_count = 3;
 		max_brightness = 255;
 		use_colors = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
 	} else {
+		sixaxis_set_leds_from_id(sc->device_id, initial_values);
 		sc->led_count = 4;
 		max_brightness = 1;
 		use_colors = 0;
@@ -1248,19 +1296,20 @@ static int sony_leds_init(struct sony_sc *sc)
 		else
 			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
-		led->brightness = 0;
+		led->brightness = initial_values[n];
 		led->max_brightness = max_brightness;
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
+		sc->leds[n] = led;
+
 		ret = led_classdev_register(&hdev->dev, led);
 		if (ret) {
 			hid_err(hdev, "Failed to register LED %d\n", n);
+			sc->leds[n] = NULL;
 			kfree(led);
 			goto error_leds;
 		}
-
-		sc->leds[n] = led;
 	}
 
 	return ret;
-- 
1.8.5.3

