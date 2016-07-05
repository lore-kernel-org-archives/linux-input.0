From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 13/27] HID: wacom: leds: dynamically allocate LED groups
Date: Tue,  5 Jul 2016 16:39:09 +0200
Message-ID: <1467729563-23318-14-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933096AbcGEOjy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:39:54 -0400
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

We need to add an action to ensure wacom->led.groups is null when
wacom_led_control() gets called after the resources has been freed.

This also prevents to send a LED command when there is no support
from the device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  8 +++--
 drivers/hid/wacom_sys.c | 85 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/hid/wacom_wac.c |  2 +-
 3 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index bcfeb51..8ac1eb8 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -110,6 +110,10 @@ enum wacom_worker {
 	WACOM_WORKER_BATTERY,
 };
 
+struct wacom_group_leds {
+	u8 select; /* status led selector (0..3) */
+};
+
 struct wacom {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
@@ -118,8 +122,8 @@ struct wacom {
 	struct mutex lock;
 	struct work_struct wireless_work;
 	struct work_struct battery_work;
-	struct wacom_led {
-		u8 select[5]; /* status led selector (0..3) */
+	struct wacom_leds {
+		struct wacom_group_leds *groups;
 		u8 llv;       /* status led brightness no button (1..127) */
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index d0f5764..4d4c737 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -647,6 +647,9 @@ static int wacom_led_control(struct wacom *wacom)
 	unsigned char report_id = WAC_CMD_LED_CONTROL;
 	int buf_size = 9;
 
+	if (!wacom->led.groups)
+		return -ENOTSUPP;
+
 	if (wacom->wacom_wac.pid) { /* wireless connected */
 		report_id = WAC_CMD_WL_LED_CONTROL;
 		buf_size = 13;
@@ -662,7 +665,7 @@ static int wacom_led_control(struct wacom *wacom)
 		 * one of four values:
 		 *    0 = Low; 1 = Medium; 2 = High; 3 = Off
 		 */
-		int ring_led = wacom->led.select[0] & 0x03;
+		int ring_led = wacom->led.groups[0].select & 0x03;
 		int ring_lum = (((wacom->led.llv & 0x60) >> 5) - 1) & 0x03;
 		int crop_lum = 0;
 		unsigned char led_bits = (crop_lum << 4) | (ring_lum << 2) | (ring_led);
@@ -677,11 +680,11 @@ static int wacom_led_control(struct wacom *wacom)
 			buf[1] = led_bits;
 	}
 	else {
-		int led = wacom->led.select[0] | 0x4;
+		int led = wacom->led.groups[0].select | 0x4;
 
 		if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
 		    wacom->wacom_wac.features.type == WACOM_24HD)
-			led |= (wacom->led.select[1] << 4) | 0x40;
+			led |= (wacom->led.groups[1].select << 4) | 0x40;
 
 		buf[0] = report_id;
 		buf[1] = led;
@@ -753,7 +756,7 @@ static ssize_t wacom_led_select_store(struct device *dev, int set_id,
 
 	mutex_lock(&wacom->lock);
 
-	wacom->led.select[set_id] = id & 0x3;
+	wacom->led.groups[set_id].select = id & 0x3;
 	err = wacom_led_control(wacom);
 
 	mutex_unlock(&wacom->lock);
@@ -773,7 +776,7 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 	struct hid_device *hdev = to_hid_device(dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
 	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
-			 wacom->led.select[SET_ID]);			\
+			 wacom->led.groups[SET_ID].select);		\
 }									\
 static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
@@ -955,6 +958,35 @@ static int wacom_devm_sysfs_create_group(struct wacom *wacom,
 	return 0;
 }
 
+static void wacom_led_groups_release(void *data)
+{
+	struct wacom *wacom = data;
+
+	wacom->led.groups = NULL;
+}
+
+static int wacom_led_groups_allocate(struct wacom *wacom, int count)
+{
+	struct wacom_group_leds *groups;
+	int error;
+
+	groups = devm_kzalloc(&wacom->hdev->dev,
+			      sizeof(struct wacom_group_leds) * count,
+			      GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	error = devm_add_action_or_reset(&wacom->hdev->dev,
+					 wacom_led_groups_release,
+					 wacom);
+	if (error)
+		return error;
+
+	wacom->led.groups = groups;
+
+	return 0;
+}
+
 static int wacom_initialize_leds(struct wacom *wacom)
 {
 	int error;
@@ -968,23 +1000,34 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOS4:
 	case INTUOS4WL:
 	case INTUOS4L:
-		wacom->led.select[0] = 0;
-		wacom->led.select[1] = 0;
 		wacom->led.llv = 10;
 		wacom->led.hlv = 20;
 		wacom->led.img_lum = 10;
+
+		error = wacom_led_groups_allocate(wacom, 1);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+
 		error = wacom_devm_sysfs_create_group(wacom,
 						      &intuos4_led_attr_group);
 		break;
 
 	case WACOM_24HD:
 	case WACOM_21UX2:
-		wacom->led.select[0] = 0;
-		wacom->led.select[1] = 0;
 		wacom->led.llv = 0;
 		wacom->led.hlv = 0;
 		wacom->led.img_lum = 0;
 
+		error = wacom_led_groups_allocate(wacom, 2);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+
 		error = wacom_devm_sysfs_create_group(wacom,
 						      &cintiq_led_attr_group);
 		break;
@@ -995,16 +1038,30 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOSPS:
 	case INTUOSPM:
 	case INTUOSPL:
-		wacom->led.select[0] = 0;
-		wacom->led.select[1] = 0;
 		wacom->led.llv = 32;
 		wacom->led.hlv = 0;
 		wacom->led.img_lum = 0;
 
+		error = wacom_led_groups_allocate(wacom, 1);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+
 		error = wacom_devm_sysfs_create_group(wacom,
 						      &intuos5_led_attr_group);
 		break;
 
+	case REMOTE:
+		error = wacom_led_groups_allocate(wacom, 5);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+		return 0;
+
 	default:
 		return 0;
 	}
@@ -1204,7 +1261,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	u8 mode;
 
-	mode = wacom->led.select[index];
+	mode = wacom->led.groups[index].select;
 	if (mode >= 0 && mode < 3)
 		return snprintf(buf, PAGE_SIZE, "%d\n", mode);
 	else
@@ -1272,7 +1329,7 @@ void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		if (wacom_wac->serial[i] == serial) {
 			wacom_wac->serial[i] = 0;
-			wacom->led.select[i] = WACOM_STATUS_UNKNOWN;
+			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 			if (wacom->remote_group[i].name) {
 				sysfs_remove_group(wacom->remote_dir,
 						   &wacom->remote_group[i]);
@@ -1369,7 +1426,7 @@ static int wacom_initialize_remote(struct wacom *wacom)
 	}
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		wacom->led.select[i] = WACOM_STATUS_UNKNOWN;
+		wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		wacom_wac->serial[i] = 0;
 	}
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3e2c903..932d3ee 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -808,7 +808,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		if (wacom_wac->serial[i] == serial)
-			wacom->led.select[i] = touch_ring_mode;
+			wacom->led.groups[i].select = touch_ring_mode;
 	}
 
 	if (!wacom->battery &&
-- 
2.5.5

