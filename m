From: Ardinartsev Nikita <pinguin255@gmail.com>
Subject: [PATCH] hid-lg: Fixes immediate disconnection of Logitech Rumblepad 2
Date: Fri, 20 Jan 2017 22:20:28 +0300
Message-ID: <72472ae2-17b1-7e1b-11f2-3ff00c7c6d87@gmail.com>
Reply-To: ardinar23@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33014 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdATTUg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 14:20:36 -0500
Received: by mail-lf0-f65.google.com with SMTP id x1so9431523lff.0
        for <linux-input@vger.kernel.org>; Fri, 20 Jan 2017 11:20:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

hid-lg: Fixes immediate disconnection of Logitech Rumblepad 2

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091
Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>
---
  drivers/hid/hid-lg.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c5c5fbe..f1afb6b 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -872,7 +872,7 @@ static const struct hid_device_id lg_devices[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
  		.driver_data = LG_NOGET | LG_FF4 },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
-		.driver_data = LG_FF2 },
+		.driver_data = LG_FF2 | LG_NOGET },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
  		.driver_data = LG_FF3 },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR),
-- 
2.7.4
