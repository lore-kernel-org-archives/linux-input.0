From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Wed, 8 Jun 2011 13:31:26 +0200
Message-ID: <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
	<BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
	<20110603124428.GA2379@nautilus.holoscopio.com>
	<BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63945 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1FHLb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 07:31:27 -0400
Received: by wwa36 with SMTP id 36so462240wwa.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2011 04:31:26 -0700 (PDT)
In-Reply-To: <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Chih-Wei and Cascardo,

Sorry for coming late in the discussion, but I think I can add some ide=
as to it.

Most of the time, when we (the multitouch guys) saw a device that
sends ABS_Z and ABS_RX, and that the problem is worked around by
adding the MULTI_INPUT quirk, that means to us that the device is a
multitouch Win7 compatible one. So hid-multitouch must be able to
handle it.

Chih-Wei, if you are running android-x86 2.6.38 kernel, then removing
the quirk should tell the generic hid layer not to handle it.
Then adding it to the list of the devices handled by hid-multitouch
should do the job: insert in mt_device the following


+	/* TouchPack touchscreen */
+	{ .driver_data =3D MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK,
+			USB_DEVICE_ID_TOUCHPACK_RTS) },
+

=46or a proper kernel integration, we'll also need to add it to the
hid_have_special_driver list in hid-core, but android-x86 kernel
doesn't need it currently.

On Wed, Jun 8, 2011 at 12:33, Chih-Wei Huang <cwhuang@android-x86.org> =
wrote:
> 2011/6/3 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
>> You should use the device capabilities, like what events it does
>> generate. If it does generate X and Y axis events, that's the right
>> device.
>
> Did you mean ABS_X and ABS_Y? Actually it is.
> The android framework detects the touch device by:
>
> =A0 =A0// Is this an old style single-touch driver?
> =A0 =A0 if (test_bit(BTN_TOUCH, key_bitmask)
> =A0 =A0 =A0 =A0 =A0 =A0 && test_bit(ABS_X, abs_bitmask) && test_bit(A=
BS_Y, abs_bitmask)) {
> =A0 =A0 =A0 =A0 device->classes |=3D CLASS_TOUCHSCREEN;
> =A0 =A0 }
>
> However, the output of getevent -p shows
>
> add device 2: /dev/input/event7
> =A0name: =A0 =A0 "HID TOUCH HID Touch Panel"
> =A0events:
> =A0 =A0SYN (0000): 0000 =A00001 =A00003 =A00004
> =A0 =A0KEY (0001): 0110 =A00111 =A00112
> =A0 =A0ABS (0003): 0000 =A0value 1428, min 0, max 4095, fuzz 0 flat 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00001 =A0value 1066, min 0, max 4095, f=
uzz 0 flat 0
> =A0 =A0MSC (0004): 0004
>
> add device 3: /dev/input/event6
> =A0name: =A0 =A0 "HID TOUCH HID Touch Panel"
> =A0events:
> =A0 =A0SYN (0000): 0000 =A00001 =A00003 =A00004
> =A0 =A0KEY (0001): 0140 =A0014a =A0014b
> =A0 =A0ABS (0003): 0000 =A0value 0, min 0, max 4095, fuzz 0 flat 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00001 =A0value 0, min 0, max 4095, fuzz=
 0 flat 0
> =A0 =A0MSC (0004): 0004
>
> Only event6 supports BTN_TOUCH, so it is detected
> as the touch device. However, that's wrong --
> event7 is the right touch device.
>
> By removing the check test_bit(BTN_TOUCH, key_bitmask),
> event7 is correctly detected and touchscreen now works.
>
> But I still have questions:
>
> * Is it intended to NOT support BTN_TOUCH in event7?
> * Why two devices are detected by the kernel,
> =A0while there is only one touchscreen?

That's the MULTI_INPUT quirk purpose, when the generic hid layer is
not able to understand the report descriptors, one way to handle the
different collections (i.e. touches) that contains the same fields is
to split the device in several ones, one per touch.

Cheers,
Benjamin

PS: Chih-Wei and Cascardo, if you need a patch instead of my awful
English, don't hesitate to ask... ;-)


>
> --
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
