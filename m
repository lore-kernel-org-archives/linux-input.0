From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH 1/3] hid: sony: Relax duplicate checking for USB-only devices
Date: Thu, 22 Sep 2016 20:18:08 -0400
Message-ID: <1474589890-7141-2-git-send-email-frank.praznik@gmail.com>
References: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34351 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933536AbcIWASh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 20:18:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id b204so6205893qkc.1
        for <linux-input@vger.kernel.org>; Thu, 22 Sep 2016 17:18:37 -0700 (PDT)
In-Reply-To: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, Frank Praznik <frank.praznik@gmail.com>

Some USB-only devices which masquerade as Sixaxis controllers report the
same generic Bluetooth address for all hardware when queried via the HID
report. This causes these devices to be wrongly rejected as duplicates
when more than one is connected at once.

This introduces a connection type comparison when checking for duplicates
and only rejects the newly connected device if the existing matching
device is connected using a different connection protocol.

The results of the connection type comparison are also used when
registering power supply info as the device Bluetooth address is used
as the unique identifier string.  In cases where more than one valid
device has the same Bluetooth address the device ID is now appended
to the power supply name string to avoid name collisions when
registering the power supply information.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 310436a..92f27b7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -65,6 +65,8 @@
 				MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
 				MOTION_CONTROLLER)
+#define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT |\
+			MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
 
 #define MAX_LEDS 4
 
@@ -2039,8 +2041,11 @@ static int sony_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int sony_battery_probe(struct sony_sc *sc)
+static int sony_battery_probe(struct sony_sc *sc, int append_dev_id)
 {
+	const char *battery_str_fmt = append_dev_id ?
+		"sony_controller_battery_%pMR_%i" :
+		"sony_controller_battery_%pMR";
 	struct power_supply_config psy_cfg = { .drv_data = sc, };
 	struct hid_device *hdev = sc->hdev;
 	int ret;
@@ -2056,9 +2061,8 @@ static int sony_battery_probe(struct sony_sc *sc)
 	sc->battery_desc.get_property = sony_battery_get_property;
 	sc->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	sc->battery_desc.use_for_apm = 0;
-	sc->battery_desc.name = kasprintf(GFP_KERNEL,
-					  "sony_controller_battery_%pMR",
-					  sc->mac_address);
+	sc->battery_desc.name = kasprintf(GFP_KERNEL, battery_str_fmt,
+					  sc->mac_address, sc->device_id);
 	if (!sc->battery_desc.name)
 		return -ENOMEM;
 
@@ -2094,7 +2098,21 @@ static void sony_battery_remove(struct sony_sc *sc)
  * it will show up as two devices. A global list of connected controllers and
  * their MAC addresses is maintained to ensure that a device is only connected
  * once.
+ *
+ * Some USB-only devices masquerade as Sixaxis controllers and all have the
+ * same dummy Bluetooth address, so a comparison of the connection type is
+ * required.  Devices are only rejected in the case where two devices have
+ * matching Bluetooth addresses on different bus types.
  */
+static inline int sony_compare_connection_type(struct sony_sc *sc0,
+						struct sony_sc *sc1)
+{
+	const int sc0_not_bt = !(sc0->quirks & SONY_BT_DEVICE);
+	const int sc1_not_bt = !(sc1->quirks & SONY_BT_DEVICE);
+
+	return sc0_not_bt == sc1_not_bt;
+}
+
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
@@ -2107,9 +2125,14 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 		ret = memcmp(sc->mac_address, entry->mac_address,
 				sizeof(sc->mac_address));
 		if (!ret) {
-			ret = -EEXIST;
-			hid_info(sc->hdev, "controller with MAC address %pMR already connected\n",
+			if (sony_compare_connection_type(sc, entry)) {
+				ret = 1;
+			} else {
+				ret = -EEXIST;
+				hid_info(sc->hdev,
+				"controller with MAC address %pMR already connected\n",
 				sc->mac_address);
+			}
 			goto unlock;
 		}
 	}
@@ -2285,6 +2308,7 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
+	int append_dev_id;
 	unsigned long quirks = id->driver_data;
 	struct sony_sc *sc;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
@@ -2379,7 +2403,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret < 0)
 		goto err_stop;
 
-	ret = sony_check_add(sc);
+	ret = append_dev_id = sony_check_add(sc);
 	if (ret < 0)
 		goto err_stop;
 
@@ -2390,7 +2414,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	if (sc->quirks & SONY_BATTERY_SUPPORT) {
-		ret = sony_battery_probe(sc);
+		ret = sony_battery_probe(sc, append_dev_id);
 		if (ret < 0)
 			goto err_stop;
 
-- 
2.7.4

