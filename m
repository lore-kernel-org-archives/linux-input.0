From: Huei-Horng Yo <hiroshi@ghostsinthelab.org>
Subject: Re: [PATCH] HID: Add Apple wireless keyboard 2011 JIS model support
Date: Tue, 04 Feb 2014 15:03:45 +0800
Message-ID: <52F090D1.1020104@ghostsinthelab.org>
References: <52EFD4B9.9070603@ghostsinthelab.org> <52F06D95.9020007@ghostsinthelab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:64960 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaBDHDw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 02:03:52 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so8098572pbb.3
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 23:03:51 -0800 (PST)
Received: from [192.168.1.101] ([49.159.89.73])
        by mx.google.com with ESMTPSA id da3sm62954545pbc.30.2014.02.03.23.03.49
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 23:03:50 -0800 (PST)
In-Reply-To: <52F06D95.9020007@ghostsinthelab.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear all,
=E6=96=BC =E8=A5=BF=E5=85=832014=E5=B9=B402=E6=9C=8804=E6=97=A5 12:33, =
Huei-Horng Yo =E6=8F=90=E5=88=B0:
> Hello,
> =E6=96=BC =E8=A5=BF=E5=85=832014=E5=B9=B402=E6=9C=8804=E6=97=A5 01:41=
, Huei-Horng Yo =E6=8F=90=E5=88=B0:
>> Hello,
>>
>> I bought an Apple wireless keyboard 2011 JIS model,
>> the 'fn' key isn't work as expected in Linux 3.12.9.
>>
>> What my patch mainly does is to add support for that model.
>>
>> Before applying this patch, the keyboard behaves like a general keyb=
oard,
>> its 'fn' key has no function to be used with arrow keys to do Home, =
End,
>> Page Up and Page Down.
>>
>> I found that this is because the HID IDs list hasn't it in vendor ID
>> 0x05ac (APPLE) section,
>> so I add the production ID 0x0257 (got the value by using bluetoothc=
tl)
>> in drivers/hid/hid-ids.h
>> and add the corresponding codes in drivers/hid/hid-apple.c &
>> drivers/hid/hid-core.c.
>>
>> Thanks,
>> Huei-Horng Yo
>>
>>
>> P.S. Also reported in
>> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=3D69681
>> <https://bugzilla.kernel.org/show_bug.cgi?id=3D69681>
>
> Here is a patch for mainline (3.14-rc1):
>


Sorry to forgot to tag HID subsystem again. It's my first time to send=20
Linux kernel patch personally, thanks for your kindly guidance, please=20
correct me if I still have mistakes to contribute.


Huei-Horng Yo

0001-HID-Add-Apple-wireless-keyboard-2011-JIS-model-suppo.patch

 From 9fd98c73db3fad5905eeb73fbc2a30550e64244e Mon Sep 17 00:00:00 2001
=46rom: Huei-Horng Yo <hiroshi@ghostsinthelab.org>
Date: Tue, 4 Feb 2014 12:14:06 +0800
Subject: [PATCH] HID: Add Apple wireless keyboard 2011 JIS model suppor=
t.

---
  drivers/hid/hid-apple.c | 3 +++
  drivers/hid/hid-core.c  | 1 +
  drivers/hid/hid-ids.h   | 1 +
  3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 4975581..f822fd2 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -469,6 +469,9 @@ static const struct hid_device_id apple_devices[] =3D=
 {
  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
  				USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
  		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+				USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS),
+		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS),
  		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3bfac3a..bb5c494 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1679,6 +1679,7 @@ static const struct hid_device_id=20
hid_have_special_driver[] =3D {
  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI) },
  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,=20
USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_AUREAL, USB_DEVICE_ID_AUREAL_W01RN) }=
,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a5248f..2c59283 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -135,6 +135,7 @@
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS   0x023b
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI  0x0255
  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
+#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
--=20
1.8.5.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
