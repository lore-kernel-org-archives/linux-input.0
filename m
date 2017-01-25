From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 1/8] HID: wacom: Enable HID_GENERIC codepath for Bluetooth devices
Date: Wed, 25 Jan 2017 12:08:35 -0800
Message-ID: <1485374922-3417-2-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35604 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdAYUJV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so20532032pge.2
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:20 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

There no reason a Bluetooth device with the appropriate HID descriptor
couldn't be used through the HID_GENERIC codepath in the future. Ensure
that the driver attempts to bind to these devices.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0884dc9..a23b736 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4121,6 +4121,7 @@ const struct hid_device_id wacom_ids[] = {
 
 	{ USB_DEVICE_WACOM(HID_ANY_ID) },
 	{ I2C_DEVICE_WACOM(HID_ANY_ID) },
+	{ BT_DEVICE_WACOM(HID_ANY_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, wacom_ids);
-- 
2.7.4

