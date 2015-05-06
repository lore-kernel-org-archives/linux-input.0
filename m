From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 5/6] hid: sony: Simplify LED initialization and eliminate redundant copies when updating LED states
Date: Tue,  5 May 2015 20:47:32 -0400
Message-ID: <1430873253-11765-6-git-send-email-frank.praznik@oh.rr.com>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:61115 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755248AbbEFAt5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:49:57 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

Directly set the initial LED states in the device state struct instead
of copying them from a temporary array.

This allows for the removal of a redundant "x = x" copy loop in
sony_set_leds() that was taking place any time an LED was updated.

It also allows for the simplifying of the parameters in functions dealing
with LED initialization and updates since only a pointer to the sony_sc
struct is needed now.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 58 ++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d0b18a5..9370509 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1306,7 +1306,7 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
 	return ret;
 }
 
-static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+static void sixaxis_set_leds_from_id(struct sony_sc *sc)
 {
 	static const __u8 sixaxis_leds[10][4] = {
 				{ 0x01, 0x00, 0x00, 0x00 },
@@ -1321,16 +1321,18 @@ static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
 				{ 0x01, 0x01, 0x01, 0x01 }
 	};
 
-	BUG_ON(MAX_LEDS < ARRAY_SIZE(sixaxis_leds[0]));
+	int id = sc->device_id;
+
+	BUILD_BUG_ON(MAX_LEDS < ARRAY_SIZE(sixaxis_leds[0]));
 
 	if (id < 0)
 		return;
 
 	id %= 10;
-	memcpy(values, sixaxis_leds[id], sizeof(sixaxis_leds[id]));
+	memcpy(sc->led_state, sixaxis_leds[id], sizeof(sixaxis_leds[id]));
 }
 
-static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
+static void dualshock4_set_leds_from_id(struct sony_sc *sc)
 {
 	/* The first 4 color/index entries match what the PS4 assigns */
 	static const __u8 color_code[7][3] = {
@@ -1343,46 +1345,44 @@ static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
 			/* White  */	{ 0x01, 0x01, 0x01 }
 	};
 
-	BUG_ON(MAX_LEDS < ARRAY_SIZE(color_code[0]));
+	int id = sc->device_id;
+
+	BUILD_BUG_ON(MAX_LEDS < ARRAY_SIZE(color_code[0]));
 
 	if (id < 0)
 		return;
 
 	id %= 7;
-	memcpy(values, color_code[id], sizeof(color_code[id]));
+	memcpy(sc->led_state, color_code[id], sizeof(color_code[id]));
 }
 
-static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
+static void buzz_set_leds(struct sony_sc *sc)
 {
+	struct hid_device *hdev = sc->hdev;
 	struct list_head *report_list =
 		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
 	struct hid_report *report = list_entry(report_list->next,
 		struct hid_report, list);
 	__s32 *value = report->field[0]->value;
 
+	BUILD_BUG_ON(MAX_LEDS < 4);
+
 	value[0] = 0x00;
-	value[1] = leds[0] ? 0xff : 0x00;
-	value[2] = leds[1] ? 0xff : 0x00;
-	value[3] = leds[2] ? 0xff : 0x00;
-	value[4] = leds[3] ? 0xff : 0x00;
+	value[1] = sc->led_state[0] ? 0xff : 0x00;
+	value[2] = sc->led_state[1] ? 0xff : 0x00;
+	value[3] = sc->led_state[2] ? 0xff : 0x00;
+	value[4] = sc->led_state[3] ? 0xff : 0x00;
 	value[5] = 0x00;
 	value[6] = 0x00;
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
+static void sony_set_leds(struct sony_sc *sc)
 {
-	int n;
-
-	BUG_ON(count > MAX_LEDS);
-
-	if (sc->quirks & BUZZ_CONTROLLER && count == 4) {
-		buzz_set_leds(sc->hdev, leds);
-	} else {
-		for (n = 0; n < count; n++)
-			sc->led_state[n] = leds[n];
+	if (!(sc->quirks & BUZZ_CONTROLLER))
 		schedule_work(&sc->state_worker);
-	}
+	else
+		buzz_set_leds(sc);
 }
 
 static void sony_led_set_brightness(struct led_classdev *led,
@@ -1422,8 +1422,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 			drv_data->led_delay_on[n] = 0;
 			drv_data->led_delay_off[n] = 0;
 
-			sony_set_leds(drv_data, drv_data->led_state,
-					drv_data->led_count);
+			sony_set_leds(drv_data);
 			break;
 		}
 	}
@@ -1529,7 +1528,6 @@ static int sony_leds_init(struct sony_sc *sc)
 	const char *name_fmt;
 	static const char * const ds4_name_str[] = { "red", "green", "blue",
 						  "global" };
-	__u8 initial_values[MAX_LEDS] = { 0 };
 	__u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
 	__u8 use_hw_blink[MAX_LEDS] = { 0 };
 
@@ -1544,8 +1542,8 @@ static int sony_leds_init(struct sony_sc *sc)
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
-		dualshock4_set_leds_from_id(sc->device_id, initial_values);
-		initial_values[3] = 1;
+		dualshock4_set_leds_from_id(sc);
+		sc->led_state[3] = 1;
 		sc->led_count = 4;
 		memset(max_brightness, 255, 3);
 		use_hw_blink[3] = 1;
@@ -1559,7 +1557,7 @@ static int sony_leds_init(struct sony_sc *sc)
 		name_len = 0;
 		name_fmt = "%s:%s";
 	} else {
-		sixaxis_set_leds_from_id(sc->device_id, initial_values);
+		sixaxis_set_leds_from_id(sc);
 		sc->led_count = 4;
 		memset(use_hw_blink, 1, 4);
 		use_ds4_names = 0;
@@ -1572,7 +1570,7 @@ static int sony_leds_init(struct sony_sc *sc)
 	 * only relevant if the driver is loaded after somebody actively set the
 	 * LEDs to on
 	 */
-	sony_set_leds(sc, initial_values, sc->led_count);
+	sony_set_leds(sc);
 
 	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
 
@@ -1595,7 +1593,7 @@ static int sony_leds_init(struct sony_sc *sc)
 		else
 			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
-		led->brightness = initial_values[n];
+		led->brightness = sc->led_state[n];
 		led->max_brightness = max_brightness[n];
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
-- 
2.1.0

