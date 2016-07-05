From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 25/27] HID: wacom: leds: fix ordering of LED banks
Date: Tue,  5 Jul 2016 16:39:21 +0200
Message-ID: <1467729563-23318-26-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Historically, 21UX2 and 24HD have the select groups inverted
(0 is the right LED bank, and 1 the left one).

This is not right, so fix that in the new LED API. For backward
compatibility, we keep the wacom_led sysfs ABI stable. We don't
need to care about luminance for these two devices as only the
select sysfs file gets exported (brightness is not configurable).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b88896c..153e453 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -683,8 +683,10 @@ static int wacom_led_control(struct wacom *wacom)
 		int led = wacom->led.groups[0].select | 0x4;
 
 		if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
-		    wacom->wacom_wac.features.type == WACOM_24HD)
-			led |= (wacom->led.groups[1].select << 4) | 0x40;
+		    wacom->wacom_wac.features.type == WACOM_24HD) {
+			led <<= 4;
+			led |= wacom->led.groups[1].select | 0x04;
+		}
 
 		buf[0] = report_id;
 		buf[1] = led;
@@ -742,6 +744,19 @@ out:
 	return retval;
 }
 
+static inline int wacom_led_select_get_id(struct wacom *wacom, int set_id)
+{
+	/*
+	 * Historically, 21UX2 and 24HD have the select groups inverted
+	 * (0 is the right LED bank, and 1 the left one)
+	 */
+	if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
+	    wacom->wacom_wac.features.type == WACOM_24HD)
+		return 1 - set_id;
+
+	return set_id;
+}
+
 static ssize_t wacom_led_select_store(struct device *dev, int set_id,
 				      const char *buf, size_t count)
 {
@@ -754,6 +769,8 @@ static ssize_t wacom_led_select_store(struct device *dev, int set_id,
 	if (err)
 		return err;
 
+	set_id = wacom_led_select_get_id(wacom, set_id);
+
 	mutex_lock(&wacom->lock);
 
 	wacom->led.groups[set_id].select = id & 0x3;
@@ -775,8 +792,9 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
 {									\
 	struct hid_device *hdev = to_hid_device(dev);\
 	struct wacom *wacom = hid_get_drvdata(hdev);			\
+	int set_id = wacom_led_select_get_id(wacom, SET_ID);		\
 	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
-			 wacom->led.groups[SET_ID].select);		\
+			 wacom->led.groups[set_id].select);		\
 }									\
 static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
 		    wacom_led##SET_ID##_select_show,			\
-- 
2.5.5
