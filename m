From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 05/27] HID: wacom: use one work queue per task
Date: Tue,  5 Jul 2016 16:39:01 +0200
Message-ID: <1467729563-23318-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Looks like the battery hijacked the wireless worker. That's not fair so
use a work queue per task.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     | 21 ++++++++++++++++++---
 drivers/hid/wacom_sys.c | 10 ++++++----
 drivers/hid/wacom_wac.c | 13 +++++--------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 4681a65..a968fbb 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -105,13 +105,19 @@
 #define USB_VENDOR_ID_WACOM	0x056a
 #define USB_VENDOR_ID_LENOVO	0x17ef
 
+enum wacom_worker {
+	WACOM_WORKER_WIRELESS,
+	WACOM_WORKER_BATTERY,
+};
+
 struct wacom {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
 	struct wacom_wac wacom_wac;
 	struct hid_device *hdev;
 	struct mutex lock;
-	struct work_struct work;
+	struct work_struct wireless_work;
+	struct work_struct battery_work;
 	struct wacom_led {
 		u8 select[5]; /* status led selector (0..3) */
 		u8 llv;       /* status led brightness no button (1..127) */
@@ -127,10 +133,19 @@ struct wacom {
 	struct attribute_group remote_group[5];
 };
 
-static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
+static inline void wacom_schedule_work(struct wacom_wac *wacom_wac,
+				       enum wacom_worker which)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
-	schedule_work(&wacom->work);
+
+	switch (which) {
+	case WACOM_WORKER_WIRELESS:
+		schedule_work(&wacom->wireless_work);
+		break;
+	case WACOM_WORKER_BATTERY:
+		schedule_work(&wacom->battery_work);
+		break;
+	}
 }
 
 extern const struct hid_device_id wacom_ids[];
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index af2801d..54f0260 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1527,7 +1527,7 @@ static void wacom_calculate_res(struct wacom_features *features)
 
 void wacom_battery_work(struct work_struct *work)
 {
-	struct wacom *wacom = container_of(work, struct wacom, work);
+	struct wacom *wacom = container_of(work, struct wacom, battery_work);
 
 	if ((wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
 	     !wacom->battery) {
@@ -1743,7 +1743,7 @@ fail_allocate_inputs:
 
 static void wacom_wireless_work(struct work_struct *work)
 {
-	struct wacom *wacom = container_of(work, struct wacom, work);
+	struct wacom *wacom = container_of(work, struct wacom, wireless_work);
 	struct usb_device *usbdev = wacom->usbdev;
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct hid_device *hdev1, *hdev2;
@@ -1871,7 +1871,8 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom->usbdev = dev;
 	wacom->intf = intf;
 	mutex_init(&wacom->lock);
-	INIT_WORK(&wacom->work, wacom_wireless_work);
+	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
+	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -1912,7 +1913,8 @@ static void wacom_remove(struct hid_device *hdev)
 
 	hid_hw_stop(hdev);
 
-	cancel_work_sync(&wacom->work);
+	cancel_work_sync(&wacom->wireless_work);
+	cancel_work_sync(&wacom->battery_work);
 	kobject_put(wacom->remote_dir);
 	wacom_destroy_leds(wacom);
 	wacom_clean_inputs(wacom);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d6746ca..c7707b2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -814,8 +814,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (!wacom->battery &&
 	    !(features->quirks & WACOM_QUIRK_BATTERY)) {
 		features->quirks |= WACOM_QUIRK_BATTERY;
-		INIT_WORK(&wacom->work, wacom_battery_work);
-		wacom_schedule_work(wacom_wac);
+		wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
 	}
 
 	wacom_notify_battery(wacom_wac, bat_percent, bat_charging, 1,
@@ -2150,7 +2149,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 		charging = !!(data[5] & 0x80);
 		if (wacom->pid != pid) {
 			wacom->pid = pid;
-			wacom_schedule_work(wacom);
+			wacom_schedule_work(wacom, WACOM_WORKER_WIRELESS);
 		}
 
 		if (w->battery)
@@ -2159,7 +2158,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
 		wacom->pid = 0;
-		wacom_schedule_work(wacom);
+		wacom_schedule_work(wacom, WACOM_WORKER_WIRELESS);
 		wacom_notify_battery(wacom, 0, 0, 0, 0);
 	}
 
@@ -2194,15 +2193,13 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		if (!wacom->battery &&
 		    !(features->quirks & WACOM_QUIRK_BATTERY)) {
 			features->quirks |= WACOM_QUIRK_BATTERY;
-			INIT_WORK(&wacom->work, wacom_battery_work);
-			wacom_schedule_work(wacom_wac);
+			wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
 		}
 	}
 	else if ((features->quirks & WACOM_QUIRK_BATTERY) &&
 		 wacom->battery) {
 		features->quirks &= ~WACOM_QUIRK_BATTERY;
-		INIT_WORK(&wacom->work, wacom_battery_work);
-		wacom_schedule_work(wacom_wac);
+		wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
 		wacom_notify_battery(wacom_wac, 0, 0, 0, 0);
 	}
 	return 0;
-- 
2.5.5
