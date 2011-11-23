From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 6/8] HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Wed, 23 Nov 2011 12:32:49 +0100
Message-ID: <CAN+gG=FMJL9EyKXFEF6vcFJe6jrU9bryieKD7+vdu3wp03uhmw@mail.gmail.com>
References: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
	<1322042074-3759-7-git-send-email-benjamin.tissoires@enac.fr>
	<201111231146.51325.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63772 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1KWLcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 06:32:51 -0500
In-Reply-To: <201111231146.51325.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 23, 2011 at 11:46, Marek Vasut <marek.vasut@gmail.com> wrot=
e:
>> From: Marek Vasut <marek.vasut@gmail.com>
>>
>> This patch adds USB ID for the touchpanel in Acer Iconia W500. The p=
anel
>> supports up to five fingers, therefore the need for a new addition o=
f panel
>> types.
>>
>> originally Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> CC: Marek Vasut <marek.vasut@gmail.com>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-multitouch.c | =A0 =A03 +++
>> =A03 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index b776bfb..e3c9e61 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1409,6 +1409,7 @@ static const struct hid_device_id
>> hid_have_special_driver[] =3D { { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C) }, {
>> HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B) }, {
>> HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72A1) }, + =A0 =A0 =A0 {
>> HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7302) }, {
>> HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) }, {
>> HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM08=
4) },
>> { HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2515) }, dif=
f
>> --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index a9526fd..fc49ab3 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -235,6 +235,7 @@
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C =A0 =A00x720c
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B =A0 =A00x726b
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72A1 =A0 =A00x72a1
>> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7302 =A0 =A00x7302
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001 =A0 =A00xa001
>>
>> =A0#define USB_VENDOR_ID_ELECOM =A0 =A0 =A0 =A0 0x056e
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index db39228..8e920cd 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -701,6 +701,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH_72A1) },
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH_7302) },
>> + =A0 =A0 { .driver_data =3D MT_CLS_EGALAX,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH_A001) },
>>
>> =A0 =A0 =A0 /* Elo TouchSystems IntelliTouch Plus panel */
>
> It seems good, but how do you detect the number of fingers the panel =
can handle?
> That's autodetected now?

Yes, I removed the .maxcontact field it in patch 4/8 in the series.

Cheers,
Benjamin

>
> M
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
