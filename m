From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 7/7] HID: sony: Prevent devices from being connected twice
Date: Wed, 29 Jan 2014 12:33:17 -0500
Message-ID: <1391016797-12842-8-git-send-email-frank.praznik@oh.rr.com>
References: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63872 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbaA2Rdx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 12:33:53 -0500
In-Reply-To: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Prevent one controller from being connected twice and showing up as two devices
if a USB cable is plugged into the controller when it is already connected via
Bluetooth.

A global list of connected devices is maintained and newly connected controllers
are checked against this list. If it is found to already be present, the probe
function exits with an return value of EEXIST.

The MAC address of the Dualshock 4 is used as an identifier to track connected
controllers. It is retrieved with feature report 0x81 when connected via USB and
via the UNIQ identifier on a Bluetooth connection.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e478265..a24d021 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -710,8 +710,12 @@ static enum power_supply_property sony_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 };
 
+static spinlock_t sony_dev_list_lock;
+static LIST_HEAD(sony_device_list);
+
 struct sony_sc {
 	spinlock_t lock;
+	struct list_head device_list;
 	struct hid_device *hdev;
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
@@ -723,6 +727,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
+	__u8 mac_address[6];
 	__u8 cable_state;
 	__u8 battery_charging;
 	__u8 battery_capacity;
@@ -1471,6 +1476,94 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	return 0;
 }
 
+/* If a controller is plugged in via USB while already connected via Bluetooth
+ * it will show up as two devices. A global list of connected controllers and
+ * their MAC addresses is maintained to ensure that a device is only connected
+ * once.
+ */
+static int sony_check_add_dev_list(struct sony_sc *sc)
+{
+	struct sony_sc *entry;
+	struct list_head *pos;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&sony_dev_list_lock, flags);
+
+	list_for_each(pos, &sony_device_list) {
+		entry = list_entry(pos, struct sony_sc, device_list);
+		ret = memcmp(sc->mac_address, entry->mac_address,
+				FIELD_SIZEOF(struct sony_sc, mac_address));
+		if (!ret) {
+			hid_info(sc->hdev, "Controller already connected\n");
+			return -EEXIST;
+		}
+	}
+
+	list_add(&(sc->device_list), &sony_device_list);
+
+	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+
+	return 0;
+}
+
+static void sony_remove_dev_list(struct sony_sc *sc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	list_del(&(sc->device_list));
+	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+}
+
+static int dualshock4_check_add(struct sony_sc *sc)
+{
+	int ret;
+
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+		int n;
+		unsigned int mac_addr[6];
+
+		/* HIDP stores the device MAC address in the uniq member */
+		ret = strlen(sc->hdev->uniq);
+		if (ret != 17) {
+			hid_err(sc->hdev, "Malformed controller MAC address\n");
+			return -EINVAL;
+		}
+
+		ret = sscanf(sc->hdev->uniq, "%02x:%02x:%02x:%02x:%02x:%02x",
+			&mac_addr[5], &mac_addr[4], &mac_addr[3], &mac_addr[2],
+			&mac_addr[1], &mac_addr[0]);
+
+		if (ret != 6) {
+			hid_err(sc->hdev, "Error parsing controller MAC address\n");
+			return -EINVAL;
+		}
+
+		for (n = 5; n >= 0; n--)
+			sc->mac_address[n] = (__u8)mac_addr[n];
+	} else {
+		__u8 buf[7];
+
+		/* The MAC address of a DS4 controller connected via USB can be
+		 * retrieved with feature report 0x81.
+		 */
+		ret = sc->hdev->ll_driver->raw_request(sc->hdev, 0x81,
+			buf, sizeof(buf), HID_FEATURE_REPORT,
+			HID_REQ_GET_REPORT);
+
+		if (ret != 7) {
+			hid_err(sc->hdev, "Error retrieving with controller MAC address\n");
+			return ret;
+		}
+
+		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
+	}
+
+	ret = sony_check_add_dev_list(sc);
+	return ret;
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -1515,8 +1608,13 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) ||
-		 (sc->quirks & DUALSHOCK4_CONTROLLER_BT)) {
-		/* The Dualshock 4 touchpad supports 2 touches and has a
+		(sc->quirks & DUALSHOCK4_CONTROLLER_BT)) {
+
+		ret = dualshock4_check_add(sc);
+		if (ret)
+			goto err_stop;
+
+		 /* The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x940.
 		 */
 		ret = sony_register_touchpad(sc, 2, 1920, 940);
@@ -1580,6 +1678,11 @@ static void sony_remove(struct hid_device *hdev)
 
 	sony_destroy_ff(hdev);
 
+	if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) ||
+	    (sc->quirks & DUALSHOCK4_CONTROLLER_BT)) {
+		sony_remove_dev_list(sc);
+	}
+
 	hid_hw_stop(hdev);
 }
 
-- 
1.8.5.3

