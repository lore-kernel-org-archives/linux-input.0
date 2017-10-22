From: Mustafa Kuscu <mustafakuscu@gmail.com>
Subject: [PATCH v2] asus rog laptops GL55x keyboard backlight fix
Date: Sun, 22 Oct 2017 08:49:06 +0300
Message-ID: <CAMz_NCrLHFV=PhoGpZ6Z1SrOVzsAQxXL+3V5EZAFr0cTbLF50g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45098 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdJVFtJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Oct 2017 01:49:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id y9so2192136wrb.2
        for <linux-input@vger.kernel.org>; Sat, 21 Oct 2017 22:49:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org

Hi All,

(Updated diff path which was not a full path before, and also updated
the description for clarity in this version.)

Some ASUS ROG laptops have a backlit keyboard which is detected fine
but Fn + F3/F4 does not work in setting up backlight level.

It appears that after making the one liner change below, the backlight
level can be controlled by the Fn keys.

It is intended only to the following device: 0x0b05 1854,
P:  Vendor=0b05 ProdID=1854 Rev=03.02
S:  Manufacturer=ITE Tech. Inc.
S:  Product=ITE Device(8910)

This keyboard device can be captured as
HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1),

However, the QUIRK is only present for ROG KEYBOARD2.

   { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
    { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },

After enabling the same quirk for KEYBOARD1, it is possible to control
backlight levels.

It appears that the device is only used by hid-asus.c.

Hope this helps to other people having the same issue.

Mustafa

Signed-off-by: mustafakuscu@gmail.com

--- linux/drivers/hid/hid-asus.c.orig    2017-10-16 12:20:14.631341280 +0300
+++ linux/drivers/hid/hid-asus.c    2017-10-16 12:20:24.814674504 +0300
@@ -593,7 +593,7 @@ static const struct hid_device_id asus_d
     { HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
+        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
