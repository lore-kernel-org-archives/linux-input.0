From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/7] HID: wacom: Allow dynamic battery creation/destruction
Date: Fri,  6 Mar 2015 11:47:40 -0800
Message-ID: <1425671264-4944-10-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34229 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbbCFTsJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:48:09 -0500
Received: by pdno5 with SMTP id o5so3377476pdn.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:48:09 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

Tablets like the Intuos, Intuos Pro, and Bamboo have a connector for an
optional wireless module that can be connected on the fly. The presence
(or absence) of this module is indicated in a status report recieved
from the tablet. This patch adds a workqueue function that will create
or destroy a power_supply object at runtime to match the current state
of the WACOM_QUIRK_BATTERY flag.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index b8344b1..ad7318d 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -142,4 +142,5 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
+void wacom_battery_work(struct work_struct *work);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 957699f..dfa4be7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1057,8 +1057,7 @@ static int wacom_initialize_battery(struct wacom *wacom)
 
 static void wacom_destroy_battery(struct wacom *wacom)
 {
-	if ((wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
-	     wacom->battery.dev) {
+	if (wacom->battery.dev) {
 		power_supply_unregister(&wacom->battery);
 		wacom->battery.dev = NULL;
 		power_supply_unregister(&wacom->ac);
@@ -1329,6 +1328,20 @@ fail:
 	return;
 }
 
+void wacom_battery_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, work);
+
+	if ((wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
+	     !wacom->battery.dev) {
+		wacom_initialize_battery(wacom);
+	}
+	else if (!(wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
+		 wacom->battery.dev) {
+		wacom_destroy_battery(wacom);
+	}
+}
+
 /*
  * Not all devices report physical dimensions from HID.
  * Compute the default from hardcoded logical dimension
-- 
2.3.0

