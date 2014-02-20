From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 4/5] HID: sony: Prevent duplicate controller connections.
Date: Thu, 20 Feb 2014 11:36:03 -0500
Message-ID: <1392914164-31899-5-git-send-email-frank.praznik@oh.rr.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:53948 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbaBTQgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:14 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

If a Sixaxis or Dualshock 4 controller is connected via USB while already
connected via Bluetooth it will cause duplicate devices to be added to the
input device list.

To prevent this a global list of controllers and their MAC addresses is
maintained and new controllers are checked against this list.  If a duplicate
is found, the probe function will exit with -EEXIST.

On USB the MAC is retrieved via a feature report.  On Bluetooth neither
controller reports the MAC address in a feature report so the MAC is parsed from
the uniq string.  As uniq cannot be guaranteed to be a MAC address in every case
(uHID or the behavior of HIDP changing) a parsing failure will not prevent the
connection.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v2 addresses the issues mentioned in the v1 code review.
 
 To preempt a potential question, byte-swapping the Sixaxis MAC is correct
 behavior since addresses in the Bluetooth protocol are natively little-endian.

 drivers/hid/hid-sony.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b39e3ab..5dfa45c 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -33,6 +33,7 @@
 #include <linux/leds.h>
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
+#include <linux/list.h>
 #include <linux/input/mt.h>
 
 #include "hid-ids.h"
@@ -717,8 +718,12 @@ static enum power_supply_property sony_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 };
 
+static spinlock_t sony_dev_list_lock;
+static LIST_HEAD(sony_device_list);
+
 struct sony_sc {
 	spinlock_t lock;
+	struct list_head list_node;
 	struct hid_device *hdev;
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
@@ -730,6 +735,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
+	__u8 mac_address[6];
 	__u8 worker_initialized;
 	__u8 cable_state;
 	__u8 battery_charging;
@@ -1489,6 +1495,133 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	return 0;
 }
 
+/*
+ * If a controller is plugged in via USB while already connected via Bluetooth
+ * it will show up as two devices. A global list of connected controllers and
+ * their MAC addresses is maintained to ensure that a device is only connected
+ * once.
+ */
+static int sony_check_add_dev_list(struct sony_sc *sc)
+{
+	struct sony_sc *entry;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&sony_dev_list_lock, flags);
+
+	list_for_each_entry(entry, &sony_device_list, list_node) {
+		ret = memcmp(sc->mac_address, entry->mac_address,
+				sizeof(sc->mac_address));
+		if (!ret) {
+			ret = -EEXIST;
+			hid_info(sc->hdev, "controller with MAC address %pMR already connected\n",
+				sc->mac_address);
+			goto unlock;
+		}
+	}
+
+	ret = 0;
+	list_add(&(sc->list_node), &sony_device_list);
+
+unlock:
+	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+	return ret;
+}
+
+static void sony_remove_dev_list(struct sony_sc *sc)
+{
+	unsigned long flags;
+
+	if (sc->list_node.next) {
+		spin_lock_irqsave(&sony_dev_list_lock, flags);
+		list_del(&(sc->list_node));
+		spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+	}
+}
+
+static int sony_get_bt_devaddr(struct sony_sc *sc)
+{
+	int ret;
+
+	/* HIDP stores the device MAC address as a string in the uniq field. */
+	ret = strlen(sc->hdev->uniq);
+	if (ret != 17)
+		return -EINVAL;
+
+	ret = sscanf(sc->hdev->uniq,
+		"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+		&sc->mac_address[5], &sc->mac_address[4], &sc->mac_address[3],
+		&sc->mac_address[2], &sc->mac_address[1], &sc->mac_address[0]);
+
+	if (ret != 6)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sony_check_add(struct sony_sc *sc)
+{
+	int n, ret;
+
+	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
+	    (sc->quirks & SIXAXIS_CONTROLLER_BT)) {
+		/*
+		 * sony_get_bt_devaddr() attempts to parse the Bluetooth MAC
+		 * address from the uniq string where HIDP stores it.
+		 * As uniq cannot be guaranteed to be a MAC address in all cases
+		 * a failure of this function should not prevent the connection.
+		 */
+		if (sony_get_bt_devaddr(sc) < 0) {
+			hid_warn(sc->hdev, "UNIQ does not contain a MAC address; duplicate check skipped\n");
+			return 0;
+		}
+	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		__u8 buf[7];
+
+		/*
+		 * The MAC address of a DS4 controller connected via USB can be
+		 * retrieved with feature report 0x81. The address begins at
+		 * offset 1.
+		 */
+		ret = hid_hw_raw_request(sc->hdev, 0x81, buf, sizeof(buf),
+				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+		if (ret != 7) {
+			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
+			return ret < 0 ? ret : -EINVAL;
+		}
+
+		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		__u8 buf[18];
+
+		/*
+		 * The MAC address of a Sixaxis controller connected via USB can
+		 * be retrieved with feature report 0xf2. The address begins at
+		 * offset 4.
+		 */
+		ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, sizeof(buf),
+				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+		if (ret != 18) {
+			hid_err(sc->hdev, "failed to retrieve feature report 0xf2 with the Sixaxis MAC address\n");
+			return ret < 0 ? ret : -EINVAL;
+		}
+
+		/*
+		 * The Sixaxis device MAC in the report is big-endian and must
+		 * be byte-swapped.
+		 */
+		for (n = 0; n < 6; n++)
+			sc->mac_address[5-n] = buf[4+n];
+	} else {
+		return 0;
+	}
+
+	return sony_check_add_dev_list(sc);
+}
+
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -1559,6 +1692,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret < 0)
 		goto err_stop;
 
+	ret = sony_check_add(sc);
+	if (ret < 0)
+		goto err_stop;
+
 	if (sc->quirks & SONY_LED_SUPPORT) {
 		ret = sony_leds_init(hdev);
 		if (ret < 0)
@@ -1594,6 +1731,7 @@ err_stop:
 		sony_battery_remove(sc);
 	if (sc->worker_initialized)
 		cancel_work_sync(&sc->state_worker);
+	sony_remove_dev_list(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -1613,6 +1751,8 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->worker_initialized)
 		cancel_work_sync(&sc->state_worker);
 
+	sony_remove_dev_list(sc);
+
 	hid_hw_stop(hdev);
 }
 
-- 
1.8.5.3

