From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v5 5/7] HID: sony: Initialize the controller LEDs with a device ID value
Date: Mon, 14 Apr 2014 10:11:35 -0400
Message-ID: <1397484697-2389-6-git-send-email-frank.praznik@oh.rr.com>
References: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:41069 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751151AbaDNOLu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 10:11:50 -0400
In-Reply-To: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Add an IDA id allocator to assign unique, sequential device ids to Sixaxis and
DualShock 4 controllers.

Use the device ID to initialize the Sixaxis and DualShock 4 controller LEDs to
default values.  The number or color of the controller is set relative to other
connected Sony controllers.

Set the LED class brightness values to the initial values and add the new led to
the array before calling led_classdev_register so that the correct brightness
value shows up in the LED sysfs entry.

Use explicit module init and exit functions since the IDA allocator must be
manually destroyed when the module is unloaded.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c709161..f1649d0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -33,6 +33,7 @@
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/idr.h>
 #include <linux/input/mt.h>
 
 #include "hid-ids.h"
@@ -749,6 +750,7 @@ union sixaxis_output_report_01 {
 
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
+static DEFINE_IDA(sony_device_id_allocator);
 
 struct sony_sc {
 	spinlock_t lock;
@@ -758,6 +760,7 @@ struct sony_sc {
 	unsigned long quirks;
 	struct work_struct state_worker;
 	struct power_supply battery;
+	int device_id;
 
 #ifdef CONFIG_SONY_FF
 	__u8 left;
@@ -1078,6 +1081,52 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
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
@@ -1191,7 +1240,7 @@ static int sony_leds_init(struct sony_sc *sc)
 	size_t name_len;
 	const char *name_fmt;
 	static const char * const color_str[] = { "red", "green", "blue" };
-	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
+	__u8 initial_values[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
@@ -1205,12 +1254,14 @@ static int sony_leds_init(struct sony_sc *sc)
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
@@ -1245,19 +1296,20 @@ static int sony_leds_init(struct sony_sc *sc)
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
@@ -1603,6 +1655,38 @@ static int sony_check_add(struct sony_sc *sc)
 	return sony_check_add_dev_list(sc);
 }
 
+static int sony_set_device_id(struct sony_sc *sc)
+{
+	int ret;
+
+	/*
+	 * Only DualShock 4 or Sixaxis controllers get an id.
+	 * All others are set to -1.
+	 */
+	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
+	    (sc->quirks & DUALSHOCK4_CONTROLLER)) {
+		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
+					GFP_KERNEL);
+		if (ret < 0) {
+			sc->device_id = -1;
+			return ret;
+		}
+		sc->device_id = ret;
+	} else {
+		sc->device_id = -1;
+	}
+
+	return 0;
+}
+
+static void sony_release_device_id(struct sony_sc *sc)
+{
+	if (sc->device_id >= 0) {
+		ida_simple_remove(&sony_device_id_allocator, sc->device_id);
+		sc->device_id = -1;
+	}
+}
+
 static inline void sony_init_work(struct sony_sc *sc,
 					void(*worker)(struct work_struct *))
 {
@@ -1654,6 +1738,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	ret = sony_set_device_id(sc);
+	if (ret < 0) {
+		hid_err(hdev, "failed to allocate the device id\n");
+		goto err_stop;
+	}
+
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
@@ -1745,6 +1835,7 @@ err_stop:
 		sony_battery_remove(sc);
 	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
+	sony_release_device_id(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -1765,6 +1856,8 @@ static void sony_remove(struct hid_device *hdev)
 
 	sony_remove_dev_list(sc);
 
+	sony_release_device_id(sc);
+
 	hid_hw_stop(hdev);
 }
 
@@ -1809,6 +1902,22 @@ static struct hid_driver sony_driver = {
 	.report_fixup  = sony_report_fixup,
 	.raw_event     = sony_raw_event
 };
-module_hid_driver(sony_driver);
+
+static int __init sony_init(void)
+{
+	dbg_hid("Sony:%s\n", __func__);
+
+	return hid_register_driver(&sony_driver);
+}
+
+static void __exit sony_exit(void)
+{
+	dbg_hid("Sony:%s\n", __func__);
+
+	ida_destroy(&sony_device_id_allocator);
+	hid_unregister_driver(&sony_driver);
+}
+module_init(sony_init);
+module_exit(sony_exit);
 
 MODULE_LICENSE("GPL");
-- 
1.8.5.3

