From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/5] HID: wacom: generic: Ignore HID_DG_BATTERYSTRENTH == 0
Date: Fri, 28 Apr 2017 09:25:31 -0700
Message-ID: <20170428162534.3051-2-killertofu@gmail.com>
References: <20170428162534.3051-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33153 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756801AbdD1QZz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 12:25:55 -0400
Received: by mail-qk0-f194.google.com with SMTP id o85so9596856qkh.0
        for <linux-input@vger.kernel.org>; Fri, 28 Apr 2017 09:25:55 -0700 (PDT)
In-Reply-To: <20170428162534.3051-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

AES sensors use the value 0 to indicate "not available" rather than
"completely dead". Such values are often sent for dozens of reports
while the pen is being brought into proximity and can cause userspace
to get the wrong impression about the actual battery state.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1878da3321f8..c3f8fe152e48 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2034,6 +2034,8 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 			wacom_wac->hid_data.sense_state = value;
 		return;
 	case HID_DG_BATTERYSTRENGTH:
+		if (value == 0) /* "not available" */
+			break;
 		value = value * 100 / (field->logical_maximum - field->logical_minimum);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
-- 
2.12.2

