From: Mustafa Kuscu <mustafakuscu@gmail.com>
Subject: [PATCH] asus rog laptops GL55x keyboard backlight fix
Date: Mon, 16 Oct 2017 12:46:08 +0300
Message-ID: <CAMz_NCpaW7T_zUT5e8er9FRQWPd3nQLh0x5huwvcjaJkEL-JXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51241 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdJPJqK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 05:46:10 -0400
Received: by mail-wm0-f54.google.com with SMTP id f4so1273406wme.0
        for <linux-input@vger.kernel.org>; Mon, 16 Oct 2017 02:46:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: trivial@kernel.org

Dear all,

Some ASUS ROG laptops have a backlit keyboard which is detected fine
but Fn + F3/F4 does not work in setting up backlight level.

It appears that after making the one liner change below, the backlight
level can be controlled by the Fn keys.

It is intended only to the following device: 0x0b05 1854,
P:  Vendor=0b05 ProdID=1854 Rev=03.02
S:  Manufacturer=ITE Tech. Inc.
S:  Product=ITE Device(8910)

which is already captured as
HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2),

However, the QUIRK is only present for ROG KEYBOARD2.

   { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
    { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },

It appears that the device is only used by hid-asus.c.

Hope this helps to other people having the same issue.

Mustafa



--- hid-asus.c.orig    2017-10-16 12:20:14.631341280 +0300
+++ hid-asus.c    2017-10-16 12:20:24.814674504 +0300
@@ -593,7 +593,7 @@ static const struct hid_device_id asus_d
     { HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
+        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
