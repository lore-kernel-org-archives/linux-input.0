From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: No multitouch on USB keyboard/touchpad composite device
Date: Fri, 30 Jun 2017 12:28:18 +0800
Message-ID: <CAAd53p5Tcuxa9+QY_MvnOWAdmiXjzTsTPoKzj0fbRNhR+QhWJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34180 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdF3E2U (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Jun 2017 00:28:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id 70so3398284wmo.1
        for <linux-input@vger.kernel.org>; Thu, 29 Jun 2017 21:28:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, robgonorl@gmail.com

Hi,

A user has a laptop with composite keyboard/touchpad.
The touchpad does not have multitouch ability [1], since it's being
recognizes as a usb-generic device.
Currently I can only find hid-rmi has similar composite abilities, not
much else for other devices.

[    3.683550] hid-generic 0003:04F3:0400.0002: input,hiddev0,hidraw0:
USB HID v1.10 Keyboard [ITE Tech. Inc. ITE Device(8910)] on
usb-0000:00:14.0-3.1/input0
[    3.683846] input: ITE Tech. Inc. ITE Device(8910) as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.1/1-3.1:1.1/0003:04F3:0400.0003/input/input7
[    3.684027] hid-generic 0003:04F3:0400.0003: input,hidraw1: USB HID
v1.10 Mouse [ITE Tech. Inc. ITE Device(8910)] on
usb-0000:00:14.0-3.1/input1

I tried to make the touchpad (0003:04F3:0400.0003) uses
hid-multitouch, but the touchpad doesn't work this way. Also, the
keyboard (0003:04F3:0400.0002) loses its functionality because it uses
hid-multitouch.

So here are my questions:
- How to load different driver for different USB interfaces
- The best way to remote debug input devices
- How to make the touchpad work

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1400463

Here's the diff I use to make it load hid-multitouch (which doesn't work):

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6e040692f1d8..ee3cb86fb4ca 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2091,6 +2091,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MULTITOUCH)
+       { HID_USB_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
        { HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MELFAS_MT) },
 #endif
 #if IS_ENABLED(CONFIG_HID_WIIMOTE)
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 24d5b6deb571..1891d604b3b7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -161,6 +161,7 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS     0x0109
 #define MT_CLS_LG                              0x010a
 #define MT_CLS_VTL                             0x0110
+#define MT_CLS_ELAN                            0x0111

 #define MT_DEFAULT_MAXCONTACT  10
 #define MT_MAX_MAXCONTACT      250
@@ -278,6 +279,8 @@ static struct mt_class mt_classes[] = {
                        MT_QUIRK_CONTACT_CNT_ACCURATE |
                        MT_QUIRK_FORCE_GET_FEATURE,
        },
+       { .name = MT_CLS_ELAN,
+               .quirks = MT_QUIRK_ALWAYS_VALID },
        { }
 };

@@ -1569,6 +1572,9 @@ static const struct hid_device_id mt_devices[] = {
                MT_USB_DEVICE(USB_VENDOR_ID_XIROKU,
                        USB_DEVICE_ID_XIROKU_CSR2) },

+       { .driver_data = MT_CLS_ELAN,
+               MT_USB_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
+
        /* Generic MT device */
        { HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID,
HID_ANY_ID) },

Thanks.
