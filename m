From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 3/3] HID: sony: Prevent duplicate controller connections.
Date: Tue, 18 Feb 2014 17:22:03 -0500
Message-ID: <1392762123-17725-4-git-send-email-frank.praznik@oh.rr.com>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64423 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaBRWWN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 17:22:13 -0500
In-Reply-To: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

If a Sixaxis or Dualshock 4 controller is connected via USB while already
connected via Bluetooth it will cause duplicate devices to be added to the
input device list.

To prevent this a global list of controllers and their MAC addresses is
maintained and new controllers are checked against this list.  If a duplicate
is found, the probe function with exit with -EEXIST.

On USB the MAC is retrieved via a feature report.  On Bluetooth neither
controller reports the MAC address in a feature report so the MAC is parsed from
the uniq string.  As uniq cannot be guaranteed to be a MAC address in every case
(uHID or the behavior of HIDP changing) a parsing failure will not prevent the
connection.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 159 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ad1cebd..c25f0d7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -713,8 +713,12 @@ static enum power_supply_property sony_battery_props[] = {
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
@@ -726,6 +730,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
+	__u8 mac_address[6];
 	__u8 cable_state;
 	__u8 battery_charging;
 	__u8 battery_capacity;
@@ -1473,6 +1478,137 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
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
+		entry = list_entry(pos, struct sony_sc, list_node);
+		ret = memcmp(sc->mac_address, entry->mac_address,
+				sizeof(sc->mac_address));
+		if (!ret) {
+			if (sc->hdev->bus != entry->hdev->bus) {
+				ret = -EEXIST;
+				hid_info(sc->hdev, "controller with MAC address %pMR already connected\n",
+					sc->mac_address);
+			} else {
+				/* Duplicate found, but on the same bus as the
+				 * original. Allow the connection in this case.
+				 */
+				ret = 0;
+			}
+
+			spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+			return ret;
+		}
+	}
+
+	list_add(&(sc->list_node), &sony_device_list);
+	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+
+	return 0;
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
+	int ret, n;
+	unsigned int mac_addr[6];
+
+	/* HIDP stores the device MAC address as a string in the uniq field. */
+	ret = strlen(sc->hdev->uniq);
+	if (ret != 17)
+		return -EINVAL;
+
+	ret = sscanf(sc->hdev->uniq, "%02x:%02x:%02x:%02x:%02x:%02x",
+		&mac_addr[5], &mac_addr[4], &mac_addr[3], &mac_addr[2],
+		&mac_addr[1], &mac_addr[0]);
+
+	if (ret != 6)
+		return -EINVAL;
+
+	for (n = 0; n < 6; n++)
+		sc->mac_address[n] = (__u8)mac_addr[n];
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
+		/* sony_get_bt_devaddr() attempts to parse the Bluetooth MAC
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
+		/* The MAC address of a DS4 controller connected via USB can be
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
+		/* The MAC address of a Sixaxis controller connected via USB can
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
+		/* The Sixaxis device MAC in the report is in reverse order */
+		for (n = 0; n < 6; n++)
+			sc->mac_address[5-n] = buf[4+n];
+	} else {
+		return 0;
+	}
+
+	return sony_check_add_dev_list(sc);
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -1509,12 +1645,22 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
-		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
-		ret = sixaxis_set_operational_usb(hdev);
-		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
-	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
-		ret = sixaxis_set_operational_bt(hdev);
+	if (sc->quirks & SIXAXIS_CONTROLLER) {
+		if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+			hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
+			ret = sixaxis_set_operational_usb(hdev);
+		} else
+			ret = sixaxis_set_operational_bt(hdev);
+
+		if (ret < 0) {
+			hid_err(hdev, "failed to set the Sixaxis operational mode\n");
+			goto err_stop;
+		}
+
+		ret = sony_check_add(sc);
+		if (ret < 0)
+			goto err_stop;
+
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
@@ -1524,6 +1670,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				goto err_stop;
 			}
 		}
+
+		ret = sony_check_add(sc);
+		if (ret < 0)
+			goto err_stop;
+
 		/* The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x940.
 		 */
@@ -1588,6 +1739,8 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
+	sony_remove_dev_list(sc);
+
 	cancel_work_sync(&sc->state_worker);
 
 	hid_hw_stop(hdev);
-- 
1.8.5.3

