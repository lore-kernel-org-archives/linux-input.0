From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 6/6] HID: sony: Turn on the LEDs by default.
Date: Fri, 28 Feb 2014 22:59:01 -0500
Message-ID: <1393646341-16947-7-git-send-email-frank.praznik@oh.rr.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39036 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbaCAD72 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Feb 2014 22:59:28 -0500
In-Reply-To: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Initialize the controller LEDs to a default value that isn't all-off so that
there is some visible indicator that the controller is powered on and
connected.

On the Sixaxis LED number 1 is turned on.
One the DualShock 4 the light bar is set to blue at the lowest brightness.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 Right now it just sets all of the controllers to the same value (LED 1 on the
 sixaxis and blue on the DS4) to indicate that the controller is connected and
 show the battery status set by the trigger in the previous patch. I'd like to
 be able to set the LEDs to the actual numerical controller value, but I'm not
 sure how to do that, other than the solution proposed in an xpad patch a few
 weeks ago where the minor number of the joydev device was retrieved.

 drivers/hid/hid-sony.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d7889ac..7912f0a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1101,6 +1101,44 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 }
 
+static void sixaxis_set_leds_from_devnum(int devnum, __u8 values[MAX_LEDS])
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
+	devnum %= 10;
+	memcpy(values, sixaxis_leds[devnum], sizeof(sixaxis_leds[devnum]));
+}
+
+static void dualshock4_set_leds_from_devnum(int devnum, __u8 values[MAX_LEDS])
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
+	devnum %= 7;
+	memcpy(values, color_code[devnum], sizeof(color_code[devnum]));
+}
+
 static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 {
 	struct list_head *report_list =
@@ -1278,7 +1316,7 @@ static int sony_leds_init(struct sony_sc *sc)
 	size_t name_len;
 	const char *name_fmt;
 	static const char * const color_str[] = { "red", "green", "blue" };
-	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
+	__u8 initial_values[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
@@ -1292,12 +1330,14 @@ static int sony_leds_init(struct sony_sc *sc)
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		dualshock4_set_leds_from_devnum(0, initial_values);
 		sc->led_count = 3;
 		max_brightness = 255;
 		use_colors = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
 	} else {
+		sixaxis_set_leds_from_devnum(0, initial_values);
 		sc->led_count = 4;
 		max_brightness = 1;
 		use_colors = 0;
@@ -1332,7 +1372,7 @@ static int sony_leds_init(struct sony_sc *sc)
 		else
 			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
-		led->brightness = 0;
+		led->brightness = initial_values[n];
 		led->max_brightness = max_brightness;
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
-- 
1.8.5.3

