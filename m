From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] HID: wacom: do not attempt to switch mode while in probe
Date: Fri, 20 Jan 2017 16:20:13 +0100
Message-ID: <20170120152014.19775-4-benjamin.tissoires@redhat.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Intuos Pro seems to not like when we set the features right after
being powered up. Instead of waiting during probe, we can schedule the
switch mode and LED control in a deferred worker so that we don't have the
5 secs of delay from USB when the device is not accessible.

The USB timeout delays were really a pain because if you happen to unplug
the tablet while it is still waiting, you are just adding 5 second timeouts
to the USB stack. Which means that a new plug of the same tablet will also
gets delayed, and will also attempt to access the hardware while in
.probe(). So the tablet doesn't appear in the dmesg, the user unplug/replug
it to make it appearing... and so on so forth.

Really, this is for the best :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 020956c..3f650ce6 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -165,6 +165,7 @@ struct wacom {
 	struct work_struct wireless_work;
 	struct work_struct battery_work;
 	struct work_struct remote_work;
+	struct delayed_work init_work;
 	struct wacom_remote *remote;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4a2c88d..6acb422 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -497,11 +497,11 @@ static int wacom_bt_query_tablet_data(struct hid_device *hdev, u8 speed,
  * from the tablet, it is necessary to switch the tablet out of this
  * mode and into one which sends the full range of tablet data.
  */
-static int wacom_query_tablet_data(struct hid_device *hdev,
-		struct wacom_features *features)
+static int _wacom_query_tablet_data(struct wacom *wacom)
 {
-	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct hid_device *hdev = wacom->hdev;
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 
 	if (hdev->bus == BUS_BLUETOOTH)
 		return wacom_bt_query_tablet_data(hdev, 1, features);
@@ -1437,11 +1437,23 @@ static int wacom_initialize_leds(struct wacom *wacom)
 			"cannot create sysfs group err: %d\n", error);
 		return error;
 	}
-	wacom_led_control(wacom);
 
 	return 0;
 }
 
+static void wacom_init_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, init_work.work);
+
+	_wacom_query_tablet_data(wacom);
+	wacom_led_control(wacom);
+}
+
+static void wacom_query_tablet_data(struct wacom *wacom)
+{
+	schedule_delayed_work(&wacom->init_work, msecs_to_jiffies(1000));
+}
+
 static enum power_supply_property wacom_battery_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -2115,7 +2127,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	if (!wireless) {
 		/* Note that if query fails it is not a hard failure */
-		wacom_query_tablet_data(hdev, features);
+		wacom_query_tablet_data(wacom);
 	}
 
 	/* touch only Bamboo doesn't support pen */
@@ -2445,6 +2457,7 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom->usbdev = dev;
 	wacom->intf = intf;
 	mutex_init(&wacom->lock);
+	INIT_DELAYED_WORK(&wacom->init_work, wacom_init_work);
 	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
@@ -2486,6 +2499,7 @@ static void wacom_remove(struct hid_device *hdev)
 
 	hid_hw_stop(hdev);
 
+	cancel_delayed_work_sync(&wacom->init_work);
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
@@ -2503,12 +2517,11 @@ static void wacom_remove(struct hid_device *hdev)
 static int wacom_resume(struct hid_device *hdev)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
-	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	mutex_lock(&wacom->lock);
 
 	/* switch to wacom mode first */
-	wacom_query_tablet_data(hdev, features);
+	_wacom_query_tablet_data(wacom);
 	wacom_led_control(wacom);
 
 	mutex_unlock(&wacom->lock);
-- 
2.9.3
