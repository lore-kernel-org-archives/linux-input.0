From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 2/2] hid-multitouch: introduce IrTouch Infrared USB device
Date: Fri, 28 Jan 2011 18:59:13 +0100
Message-ID: <AANLkTi=XKTdOBGcG8oo49=yPvSnsH5CpCsfhwwedm0eT@mail.gmail.com>
References: <1296230680-2871-1-git-send-email-benjamin.tissoires@enac.fr>
	<1296230680-2871-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110128172139.GB2586@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39592 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab1A1R7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 12:59:14 -0500
In-Reply-To: <20110128172139.GB2586@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 28, 2011 at 18:21, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> On Fri, Jan 28, 2011 at 05:04:40PM +0100, Benjamin Tissoires wrote:
>> The product id is the 42 inches one. I don't know if they have
>> other product id for the other size, or if it is a per-size product =
id.
>>
>> Tested-by: Victor Zhuk <v.zhuk@acs-ltd.ru>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>
> The canonical patch description presents the reason for the change,
> and what the patch does (not necessarily how).

It was just to keep trace of the kind of display it was. As Florian
told the 63" does not have the same PID but not also the same
protocol.
Otherwise, we can also change the name of the define, but I'm not sure
on the rule to apply here.

Thanks,
Benjamin

>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0drivers/hid/hid-multitouch.c | =A0 =A05 +++++
>> =A03 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 24cca2f..a0b117d 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -304,6 +304,7 @@ config HID_MULTITOUCH
>> =A0 =A0 =A0 =A0 Say Y here if you have one of the following devices:
>> =A0 =A0 =A0 =A0 - Cypress TrueTouch panels
>> =A0 =A0 =A0 =A0 - Hanvon dual touch panels
>> + =A0 =A0 =A0 - IrTouch Infrared USB panels
>> =A0 =A0 =A0 =A0 - Pixcir dual touch panels
>> =A0 =A0 =A0 =A0 - 'Sensing Win7-TwoFinger' panel by GeneralTouch
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 92a0d61..b1dd7ad 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -333,6 +333,9 @@
>> =A0#define USB_VENDOR_ID_IMATION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x07=
18
>> =A0#define USB_DEVICE_ID_DISC_STAKKA =A0 =A00xd000
>>
>> +#define USB_VENDOR_ID_IRTOUCHSYSTEMS 0x6615
>> +#define USB_DEVICE_ID_IRTOUCH_INFRARED_USB =A0 0x0070
>> +
>> =A0#define USB_VENDOR_ID_JESS =A0 =A0 =A0 =A0 =A0 0x0c45
>> =A0#define USB_DEVICE_ID_JESS_YUREX =A0 =A0 0x1010
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index ffe2a76..1629296 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -475,6 +475,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOU=
CH,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_GENERAL_TO=
UCH_WIN7_TWOFINGERS) },
>>
>> + =A0 =A0 /* IRTOUCH panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEM=
S,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_IRTOUCH_INFR=
ARED_USB) },
>> +
>> =A0 =A0 =A0 /* PixCir-based panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>> --
>> 1.7.3.4
>>
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
