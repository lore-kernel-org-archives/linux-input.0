From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 30/30] HID: wacom: power_supply: provide the actual model_name
Date: Wed, 13 Jul 2016 18:06:17 +0200
Message-ID: <1468425977-4819-31-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38738 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbcGMQHt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 12:07:49 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Instead of displaying a generic "tablet", now g-c-c shows a pretty
"Wacom Intuos Pro S (WL)".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

New in v2
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 11 +++++++++++
 drivers/hid/wacom_wac.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 26a8a05..b4800ea 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -134,6 +134,7 @@ struct wacom_group_leds {
 };
 
 struct wacom_battery {
+	struct wacom *wacom;
 	struct power_supply_desc bat_desc;
 	struct power_supply *battery;
 	char bat_name[WACOM_NAME_MAX];
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index d8f3d3d..edde881 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1336,6 +1336,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 }
 
 static enum power_supply_property wacom_battery_props[] = {
+	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_SCOPE,
@@ -1350,6 +1351,9 @@ static int wacom_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 
 	switch (psp) {
+		case POWER_SUPPLY_PROP_MODEL_NAME:
+			val->strval = battery->wacom->wacom_wac.name;
+			break;
 		case POWER_SUPPLY_PROP_PRESENT:
 			val->intval = battery->bat_connected;
 			break;
@@ -1392,6 +1396,8 @@ static int __wacom_initialize_battery(struct wacom *wacom,
 	if (!devres_open_group(dev, bat_desc, GFP_KERNEL))
 		return -ENOMEM;
 
+	battery->wacom = wacom;
+
 	n = atomic_inc_return(&battery_no) - 1;
 
 	bat_desc->properties = wacom_battery_props;
@@ -1863,6 +1869,9 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 		strlcpy(name, features->name, sizeof(name));
 	}
 
+	snprintf(wacom_wac->name, sizeof(wacom_wac->name), "%s%s",
+		 name, suffix);
+
 	/* Append the device type to the name */
 	snprintf(wacom_wac->pen_name, sizeof(wacom_wac->pen_name),
 		"%s%s Pen", name, suffix);
@@ -2097,6 +2106,8 @@ static void wacom_wireless_work(struct work_struct *work)
 				goto fail;
 		}
 
+		strlcpy(wacom_wac->name, wacom_wac1->name,
+			sizeof(wacom_wac->name));
 		error = wacom_initialize_battery(wacom);
 		if (error)
 			goto fail;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 8a8974c..745e2c9 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -226,6 +226,7 @@ struct wacom_remote_data {
 };
 
 struct wacom_wac {
+	char name[WACOM_NAME_MAX];
 	char pen_name[WACOM_NAME_MAX];
 	char touch_name[WACOM_NAME_MAX];
 	char pad_name[WACOM_NAME_MAX];
-- 
2.5.5

