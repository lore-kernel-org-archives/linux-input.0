From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Thu, 9 Jun 2011 19:26:58 +0800
Message-ID: <BANLkTin3MyXsDHOK+BgdXvKO5YBH=Cv5DA@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
	<BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
	<20110603124428.GA2379@nautilus.holoscopio.com>
	<BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
	<BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
	<20110608125758.GA2465@nautilus.holoscopio.com>
	<BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
	<20110608153146.GG2465@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61267 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab1FIL07 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 07:26:59 -0400
Received: by gxk21 with SMTP id 21so704881gxk.19
        for <linux-input@vger.kernel.org>; Thu, 09 Jun 2011 04:26:58 -0700 (PDT)
In-Reply-To: <20110608153146.GG2465@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

2011/6/8 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> I was referring to Benjamin's multi-touch solution, perhaps, reverting
> the multi-device patch already. By the way, did you test it without the
> multi-device patch and did it work, or did you test it only with 2.6.32?

I'm not sure if I understood you correctly.
I did these:
* remove the quirk for touchpack in hid-quirks.c
* change hid-multitouch.c as suggested by Benjamin.

Test results:
* The touchscreen is detected by hid-core.
  (only one device is detected)
* Manually modprobe hid-multitouch,
  it didn't detect the touch device.
* The android framework correctly recognized
  the touchscreen and it works well.

The whole patch shows as below:

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0c5e9c3..fab373a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -713,6 +713,11 @@ static const struct hid_device_id mt_devices[] = {
                HID_USB_DEVICE(USB_VENDOR_ID_TOUCH_INTL,
                        USB_DEVICE_ID_TOUCH_INTL_MULTI_TOUCH) },

+       /* TouchPack touchscreen */
+       { .driver_data = MT_CLS_DEFAULT,
+               HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK,
+                       USB_DEVICE_ID_TOUCHPACK_RTS) },
+
        /* Unitec panels */
        { .driver_data = MT_CLS_DEFAULT,
                HID_USB_DEVICE(USB_VENDOR_ID_UNITEC,
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 9a94b64..727f363 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -49,7 +49,7 @@ static const struct hid_blacklist {
        { USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH,
HID_QUIRK_MULTI_INPUT },
        { USB_VENDOR_ID_PANTHERLORD,
USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT |
HID_QUIRK_SKIP_OUTPUT_REPORTS },
        { USB_VENDOR_ID_PLAYDOTCOM,
USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_QUIRK_MULTI_INPUT },
-       { USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS,
HID_QUIRK_MULTI_INPUT },
+//     { USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS,
HID_QUIRK_MULTI_INPUT },

        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },


-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
