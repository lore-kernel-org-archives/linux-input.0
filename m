From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 3/4] hid-multitouch: migrate 3M PCT touch screens to the
 unified driver.
Date: Wed, 9 Mar 2011 10:13:55 +0100
Message-ID: <AANLkTi=LHwdvpJOyeVqHrpFjikr5=uKsaa_T3LKgXtDP@mail.gmail.com>
References: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
	<1299601979-4871-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110309084645.GB3569@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51822 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab1CIJN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 04:13:56 -0500
In-Reply-To: <20110309084645.GB3569@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik

On Wed, Mar 9, 2011 at 09:46, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> Hi Benjamin,
>
> On Tue, Mar 08, 2011 at 05:32:58PM +0100, Benjamin Tissoires wrote:
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>
> Semms this patch is missing a commit message.

You can copy/paste this point to the other patches as well.

How about:
"3M PCT touch screens can be handled by the unified driver. This will
ease future evolution. So, just move it."

Then I'll copy/paste for the others.

>
> [...]
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index e7a4f83..f32bf46 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -5,6 +5,11 @@
>> =A0 * =A0Copyright (c) 2010-2011 Benjamin Tissoires <benjamin.tissoi=
res@gmail.com>
>> =A0 * =A0Copyright (c) 2010-2011 Ecole Nationale de l'Aviation Civil=
e, France
>> =A0 *
>> + * =A0based on hid-3m-pct.c copyrighted as follows:
>> + * =A0 =A0Copyright (c) 2009-2010 Stephane Chatty <chatty@enac.fr>
>> + * =A0 =A0Copyright (c) 2010 =A0 =A0 =A0Henrik Rydberg <rydberg@eur=
omail.se>
>> + * =A0 =A0Copyright (c) 2010 =A0 =A0 =A0Canonical, Ltd.
>> + *
>> =A0 */
>>
>> =A0/*
>> @@ -74,6 +79,7 @@ struct mt_class {
>> =A0#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A03
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 4
>> =A0#define MT_CLS_STANTUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 5
>> +#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A06
>>
>> =A0/*
>> =A0 * these device-dependent functions determine what slot correspon=
ds
>> @@ -124,6 +130,11 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 10 },
>> =A0 =A0 =A0 { .name =3D MT_CLS_STANTUM,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_CONFIDENCE=
 },
>> + =A0 =A0 { .name =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_CONFIDENCE |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_SLOT_IS_CONTACTID=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 2048,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 128 },
>>
>> =A0 =A0 =A0 { }
>> =A0};
>> @@ -479,6 +490,14 @@ static void mt_remove(struct hid_device *hdev)
>>
>> =A0static const struct hid_device_id mt_devices[] =3D {
>>
>> + =A0 =A0 /* 3M panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_3M1968) },
>> + =A0 =A0 { .driver_data =3D MT_CLS_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_3M,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_3M2256) },
>> +
>> =A0 =A0 =A0 /* Cypress panel */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_CYPRESS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
>
> The touch width correction from the original driver has gone missing
> here. Otherwise, looks good, but will defer testing to the next round=
=2E

Oops, it's not missing, it has been transformed into sn_pressure...
Will correct it.

By looking at it, I just saw that we override values for HID_DG_HEIGHT
to the range [0-1].
I'll have to dig into.

=46or the tests, I've tested it on the 1968.

Thanks,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
