From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 1/2] hid-multitouch: work on default classes and renaming
 of classes
Date: Fri, 28 Jan 2011 18:52:35 +0100
Message-ID: <AANLkTimB2bA9JuhNox8UCsHkGEGyUQLBPnELBR0-=-ie@mail.gmail.com>
References: <1296230680-2871-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110128171852.GA2586@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47862 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1A1Rwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 12:52:37 -0500
In-Reply-To: <20110128171852.GA2586@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 28, 2011 at 18:18, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> The safest quirk for a device (the one that works out of the box for
>> most of them) is the MT_QUIRK_NOT_SEEN_MEANS_UP. Indeed, it does not
>> make any assumption on the device. When adding a new device, we can
>> easily test it against MT_CLS_DEFAULT, and then optimize it with oth=
er
>> quirks: that's why no device use MT_CLS_DEFAULT right now.
>>
>> This patch introduce also MT_CLS_DUAL_DEFAULT which has the same pur=
pose
>> than MT_CLS_DEFAULT, but for dual touch panels.
>
> But it is used anywhere?

Hi Henrik,

In it's current form, no. I often rely on it to make a quick patch
(just adding the ids in hid-ids, hid-core and hid-multitouch) to test
a new (dual touch) device. I thought it would be useful to be
mainstream.

>
>> Finally, the patch renames MT_CLS_DUAL1 to MT_CLS_DUAL_INRANGE_CONTA=
CTID
>> and MT_CLS_DUAL2 to MT_CLS_DUAL_INRANGE_CONTACTNUMBER for better
>> readability.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>
> The patch description and the content lacks a certain
> distinctness. Please single out janitory actions into a separate
> patch, or, if possible, skip it altogether.

ok, will do

>
>> =A0drivers/hid/hid-multitouch.c | =A0 25 +++++++++++++++----------
>> =A01 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 07d3183..ffe2a76 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -24,6 +24,7 @@
>>
>>
>> =A0MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
>> +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>
> Adding this is fine, based on your prior contributions. Perhaps it
> should be motivated as such in a separate patch instead.

ok

>
>> =A0MODULE_DESCRIPTION("HID multitouch panels");
>> =A0MODULE_LICENSE("GPL");
>>
>> @@ -65,10 +66,11 @@ struct mt_class {
>> =A0};
>>
>> =A0/* classes of device behavior */
>> -#define MT_CLS_DEFAULT =A0 =A0 =A0 1
>> -#define MT_CLS_DUAL1 2
>> -#define MT_CLS_DUAL2 3
>> -#define MT_CLS_CYPRESS =A0 =A0 =A0 4
>> +#define MT_CLS_DEFAULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 1
>> +#define MT_CLS_DUAL_DEFAULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +#define MT_CLS_DUAL_INRANGE_CONTACTID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
3
>> +#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A04
>> +#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 10
>
> There is no need to change the numbering for unchanged names.

I just wanted to keep device-specific at the end of the list. Hence
the 10 to keep a little space between generic and devices:
MT_CLS_DUAL_CONFIDENCE_CONTACT* are coming...


>
>>
>> =A0/*
>> =A0 * these device-dependent functions determine what slot correspon=
ds
>> @@ -104,13 +106,16 @@ static int find_slot_from_contactid(struct mt_=
device *td)
>>
>> =A0struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 { .name =3D MT_CLS_DEFAULT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_INRANGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> - =A0 =A0 { .name =3D MT_CLS_DUAL1,
>> + =A0 =A0 { .name =3D MT_CLS_DUAL_DEFAULT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>> + =A0 =A0 { .name =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_INRANGE |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SLOT_IS_CONTACT=
ID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>> - =A0 =A0 { .name =3D MT_CLS_DUAL2,
>> + =A0 =A0 { .name =3D MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_INRANGE |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SLOT_IS_CONTACT=
NUMBER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2 },
>> @@ -466,15 +471,15 @@ static const struct hid_device_id mt_devices[]=
 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CYPRESS_TR=
UETOUCH) },
>>
>> =A0 =A0 =A0 /* GeneralTouch panel */
>> - =A0 =A0 { .driver_data =3D MT_CLS_DUAL2,
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOU=
CH,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_GENERAL_TO=
UCH_WIN7_TWOFINGERS) },
>>
>> =A0 =A0 =A0 /* PixCir-based panels */
>> - =A0 =A0 { .driver_data =3D MT_CLS_DUAL1,
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_HANVON_MUL=
TITOUCH) },
>> - =A0 =A0 { .driver_data =3D MT_CLS_DUAL1,
>> + =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CANDO_PIXC=
IR_MULTI_TOUCH) },
>>
>> --
>> 1.7.3.4
>>
>
> Thanks,
> Henrik
>

Thanks for the review,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
