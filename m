From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4 v2] HID: wacom: generic: Send data only when the interface is defined
Date: Thu,  8 Dec 2016 22:04:52 -0800
Message-ID: <1481263492-6729-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33180 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbcLIGFW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 01:05:22 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so1203470pgd.0
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 22:05:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, jason.gerecke@wacom.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

From: Ping Cheng <pinglinux@gmail.com>

Sometime valid events may not be supported by the driver yet. Make
sure we don't process them when the code is not ready.

This fix prevents a kernel panic due to unsupported HID events.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-By: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f1c49a4..29d2610 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2109,11 +2109,11 @@ void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	if (wacom->wacom_wac.features.type != HID_GENERIC)
 		return;
 
-	if (WACOM_PAD_FIELD(field))
+	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
 		wacom_wac_pad_event(hdev, field, usage, value);
-	else if (WACOM_PEN_FIELD(field))
+	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_event(hdev, field, usage, value);
-	else if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_event(hdev, field, usage, value);
 }
 
@@ -2145,20 +2145,20 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 	if (wacom_wac->features.type != HID_GENERIC)
 		return;
 
-	if (WACOM_PAD_FIELD(field))
+	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
 		wacom_wac_pad_pre_report(hdev, report);
-	else if (WACOM_PEN_FIELD(field))
+	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		wacom_wac_pen_pre_report(hdev, report);
-	else if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		wacom_wac_finger_pre_report(hdev, report);
 
 	wacom_report_events(hdev, report);
 
-	if (WACOM_PAD_FIELD(field))
+	if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
 		return wacom_wac_pad_report(hdev, report);
-	else if (WACOM_PEN_FIELD(field))
+	else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
 		return wacom_wac_pen_report(hdev, report);
-	else if (WACOM_FINGER_FIELD(field))
+	else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_input)
 		return wacom_wac_finger_report(hdev, report);
 }
 
-- 
1.8.3.1

