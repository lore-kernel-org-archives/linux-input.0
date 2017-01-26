From: Ardinartsev Nikita <pinguin255@gmail.com>
Subject: [PATCH v2] hid-lg: Fix immediate disconnection of Logitech Rumblepad
 2
Date: Thu, 26 Jan 2017 16:54:42 +0300
Message-ID: <bd414b27-d1c8-9395-7552-5dfe9a3ce63a@gmail.com>
Reply-To: ardinar23@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34758 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbdAZNyq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 08:54:46 -0500
Received: by mail-lf0-f66.google.com with SMTP id q89so23753751lfi.1
        for <linux-input@vger.kernel.org>; Thu, 26 Jan 2017 05:54:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

hid-lg: Fix immediate disconnection of Logitech Rumblepad 2

With NOGET quirk Logitech F510 is now fully workable in dinput mode 
including rumble effects (according to fftest).
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091
Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>
---
  drivers/hid/hid-lg.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c5c5fbe..52026dc 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -872,7 +872,7 @@ static const struct hid_device_id lg_devices[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
  		.driver_data = LG_NOGET | LG_FF4 },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
-		.driver_data = LG_FF2 },
+		.driver_data = LG_NOGET | LG_FF2 },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 
USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
  		.driver_data = LG_FF3 },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR),
-- 
2.7.4

