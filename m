From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 1/2] HID: sony: Add battery status reporting for the Sixaxis and Dualshock 4 controllers.
Date: Mon, 27 Jan 2014 10:17:36 -0500
Message-ID: <1390835857-4523-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51844 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbaA0PSD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 10:18:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add battery status reporting for the Sixaxis and Dualshock 4 controllers.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v2 of the patch fixes a small logic error where the battery_charging flag was
 flipped on the Sixaxis.
 
 The line:  battery_charging = rd[30] & 0x01;
 should be: battery_charging = !(rd[30] & 0x01);
 
 since the low bit is 0 when charging and 1 when charging is complete.

 drivers/hid/hid-sony.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1235405..04fd611 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/leds.h>
+#include <linux/power_supply.h>
+#include <linux/spinlock.h>
 
 #include "hid-ids.h"
 
@@ -42,6 +44,7 @@
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER_USB)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_USB)
 
 #define MAX_LEDS 4
 
@@ -487,18 +490,30 @@ static const unsigned int buzz_keymap[] = {
 	[20] = BTN_TRIGGER_HAPPY20,
 };
 
+static enum power_supply_property sony_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
 struct sony_sc {
+	spinlock_t lock;
 	struct hid_device *hdev;
 	struct led_classdev *leds[MAX_LEDS];
 	struct hid_report *output_report;
 	unsigned long quirks;
 	struct work_struct state_worker;
+	struct power_supply battery;
 
 #ifdef CONFIG_SONY_FF
 	__u8 left;
 	__u8 right;
 #endif
 
+	__u8 cable_state;
+	__u8 battery_charging;
+	__u8 battery_capacity;
 	__u8 led_state[MAX_LEDS];
 	__u8 led_count;
 };
@@ -599,6 +614,63 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
+{
+	static const __u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
+	unsigned long flags;
+	__u8 cable_state, battery_capacity, battery_charging;
+
+	/* The sixaxis is charging if the battery value is 0xee
+	 * and it is fully charged if the value is 0xef.
+	 * It does not report the actual level while charging so it
+	 * is set to 100% while charging is in progress.
+	 */
+	if (rd[30] >= 0xee) {
+		battery_capacity = 100;
+		battery_charging = rd[30] & 0x01;
+	} else {
+		battery_capacity = sixaxis_battery_capacity[rd[30]];
+		battery_charging = 0;
+	}
+	cable_state = (rd[31] >> 4) & 0x01;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->cable_state = cable_state;
+	sc->battery_capacity = battery_capacity;
+	sc->battery_charging = battery_charging;
+	spin_unlock_irqrestore(&sc->lock, flags);
+}
+
+static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
+{
+	unsigned long flags;
+	__u8 cable_state, battery_capacity, battery_charging;
+
+	/* The lower 4 bits of byte 30 contain the battery level
+	 * and the 5th bit contains the USB cable state.
+	 */
+	cable_state = (rd[30] >> 4) & 0x01;
+	battery_capacity = rd[30] & 0x0F;
+
+	/* On USB the Dualshock 4 battery level goes from 0 to 11.
+	 * A battery level of 11 means fully charged.
+	 */
+	if (cable_state && battery_capacity == 11)
+		battery_charging = 0;
+	else
+		battery_charging = 1;
+
+	if (battery_capacity > 10)
+		battery_capacity--;
+	battery_capacity *= 10;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->cable_state = cable_state;
+	sc->battery_capacity = battery_capacity;
+	sc->battery_charging = battery_charging;
+	spin_unlock_irqrestore(&sc->lock, flags);
+}
+
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		__u8 *rd, int size)
 {
@@ -613,6 +685,11 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[43], rd[44]);
 		swap(rd[45], rd[46]);
 		swap(rd[47], rd[48]);
+
+		sixaxis_parse_report(sc, rd, size);
+	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
+			size == 64) {
+		dualshock4_parse_report(sc, rd, size);
 	}
 
 	return 0;
@@ -1011,6 +1088,91 @@ static void sony_destroy_ff(struct hid_device *hdev)
 }
 #endif
 
+static int sony_battery_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct sony_sc *sc = container_of(psy, struct sony_sc, battery);
+	unsigned long flags;
+	int ret = 0;
+	u8 battery_charging, battery_capacity, cable_state;
+
+	spin_lock_irqsave(&sc->lock, flags);
+	battery_charging = sc->battery_charging;
+	battery_capacity = sc->battery_capacity;
+	cable_state = sc->cable_state;
+	spin_unlock_irqrestore(&sc->lock, flags);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = battery_capacity;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (battery_charging)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			if (battery_capacity == 100 && cable_state)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int sony_battery_probe(struct sony_sc *sc)
+{
+	static atomic_t power_id_seq = ATOMIC_INIT(0);
+	unsigned long power_id;
+	struct hid_device *hdev = sc->hdev;
+	int ret;
+
+	power_id = (unsigned long)atomic_inc_return(&power_id_seq);
+
+	sc->battery.properties = sony_battery_props;
+	sc->battery.num_properties = ARRAY_SIZE(sony_battery_props);
+	sc->battery.get_property = sony_battery_get_property;
+	sc->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+	sc->battery.use_for_apm = 0;
+	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%lu",
+				     power_id);
+	if (!sc->battery.name)
+		return -ENOMEM;
+
+	ret = power_supply_register(&hdev->dev, &sc->battery);
+	if (ret) {
+		hid_err(hdev, "Unable to register battery device\n");
+		goto err_free;
+	}
+
+	power_supply_powers(&sc->battery, &hdev->dev);
+	return 0;
+
+err_free:
+	kfree(sc->battery.name);
+	sc->battery.name = NULL;
+	return ret;
+}
+
+static void sony_battery_remove(struct sony_sc *sc)
+{
+	if (!sc->battery.name)
+		return;
+
+	power_supply_unregister(&sc->battery);
+	kfree(sc->battery.name);
+	sc->battery.name = NULL;
+}
+
 static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
 {
 	struct list_head *head, *list;
@@ -1101,14 +1263,31 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto err_stop;
 	}
 
+	if (sc->quirks & SONY_BATTERY_SUPPORT) {
+		ret = sony_battery_probe(sc);
+		if (ret < 0)
+			goto err_stop;
+
+		/* Open the device to receive reports with battery info */
+		ret = hid_hw_open(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "hw open failed\n");
+			goto err_stop;
+		}
+	}
+
 	ret = sony_init_ff(hdev);
 	if (ret < 0)
-		goto err_stop;
+		goto err_close;
 
 	return 0;
+err_close:
+	hid_hw_close(hdev);
 err_stop:
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(hdev);
+	if (sc->quirks & SONY_BATTERY_SUPPORT)
+		sony_battery_remove(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -1120,6 +1299,11 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(hdev);
 
+	if (sc->quirks & SONY_BATTERY_SUPPORT) {
+		hid_hw_close(hdev);
+		sony_battery_remove(sc);
+	}
+
 	sony_destroy_ff(hdev);
 
 	hid_hw_stop(hdev);
-- 
1.8.3.2

