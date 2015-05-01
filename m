From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Do not add suffix to name of devices with an unknown type
Date: Thu, 30 Apr 2015 17:51:53 -0700
Message-ID: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34622 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbEAAwQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Apr 2015 20:52:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The naming logic currently assumes that all devices will be a pen, finger,
or pad. Though this has historically been the case, the new HID_GENERIC
catch-all may cause us to probe devices with Wacom's 056A VID which aren't
any of these types (e.g. the "Cintiq 24HDT Monitor Control"). This patch
updates the logic so that no suffix will be added to the device name if
the device type is unknown.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9c57ac0..222baf5 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1440,12 +1440,15 @@ static void wacom_update_name(struct wacom *wacom)
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
 		"%s Pad", wacom_wac->name);
 
-	if (features->device_type != BTN_TOOL_FINGER)
+	if (features->device_type == BTN_TOOL_PEN) {
 		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
-	else if (features->touch_max)
-		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
-	else
-		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+	}
+	else if (features->device_type == BTN_TOOL_FINGER) {
+		if (features->touch_max)
+			strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
+		else
+			strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+	}
 }
 
 static int wacom_probe(struct hid_device *hdev,
-- 
2.3.5

