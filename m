From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/5] HID: wacom: generic: Scale battery capacity measurements to percentages
Date: Fri, 28 Apr 2017 09:25:30 -0700
Message-ID: <20170428162534.3051-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34441 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756801AbdD1QZy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 12:25:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id y33so9082622qta.1
        for <linux-input@vger.kernel.org>; Fri, 28 Apr 2017 09:25:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The power_supply subsystem expects us to provide it with capacity values
measured in percent. In particular, AES devices (HID_DG_BATTERYSTRENGTH)
use the range 0-255, which needs to be rescaled. The MobileStudio Pro
(WACOM_HID_WD_BATTERY_LEVEL) uses the range 0-100, but there's no guarantee
that future devices will share the same range.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6b8f6b816195..1878da3321f8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1811,6 +1811,7 @@ static void wacom_wac_pad_battery_event(struct hid_device *hdev, struct hid_fiel
 
 	switch (equivalent_usage) {
 	case WACOM_HID_WD_BATTERY_LEVEL:
+		value = value * 100 / (field->logical_maximum - field->logical_minimum);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		break;
@@ -2033,6 +2034,7 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 			wacom_wac->hid_data.sense_state = value;
 		return;
 	case HID_DG_BATTERYSTRENGTH:
+		value = value * 100 / (field->logical_maximum - field->logical_minimum);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		break;
-- 
2.12.2

