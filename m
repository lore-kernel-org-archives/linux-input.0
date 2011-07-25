From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 3/3] hid-multitouch: Add LG Display Multitouch device.
Date: Mon, 25 Jul 2011 11:32:13 +0200
Message-ID: <CAN+gG=EQjdwsr33daj6B9CzJfiwMqgN_6rns+n4CFytKb9SOQw@mail.gmail.com>
References: <1311545261-34067-1-git-send-email-jeffbrown@android.com>
	<1311545261-34067-3-git-send-email-jeffbrown@android.com>
	<9B9DAF0C-EB98-4DC3-9D29-F388CB599E61@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1GYJcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 05:32:14 -0400
In-Reply-To: <9B9DAF0C-EB98-4DC3-9D29-F388CB599E61@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: jeffbrown@android.com, USB list <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jeff Brown <jeffbrown@google.com>

On Mon, Jul 25, 2011 at 11:18, St=E9phane Chatty <chatty@enac.fr> wrote=
:
>
> Le 25 juil. 2011 =E0 00:07, jeffbrown@android.com a =E9crit :
>
>> From: Jeff Brown <jeffbrown@google.com>
>>
>> Signed-off-by: jeffbrown@android.com
>> ---
>> drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> drivers/hid/hid-multitouch.c | =A0 =A05 +++++
>> 2 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index db63ccf..637e6e9 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -419,6 +419,9 @@
>> #define USB_DEVICE_ID_LD_HYBRID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2090
>> #define USB_DEVICE_ID_LD_HEATCONTROL =A00x20A0
>>
>> +#define USB_VENDOR_ID_LG =A0 =A0 =A0 =A0 =A0 =A0 0x1fd2
>> +#define USB_DEVICE_ID_LG_MULTITOUCH =A00x0064
>> +
>> #define USB_VENDOR_ID_LOGITECH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x046d
>> #define USB_DEVICE_ID_LOGITECH_RECEIVER =A0 =A0 =A0 0xc101
>> #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST =A00xc110
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 4ee21ac..b03a0b0 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -682,6 +682,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYST=
EMS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_IRTOUCH_IN=
=46RARED_USB) },
>>
>> + =A0 =A0 /* LG Display panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_LG,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LG_MULTITOUC=
H) },
>> +
>> =A0 =A0 =A0 /* Lumio panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_LUMIO,
>> --
>> 1.7.0.4
>>
>
> I don't have access to the panel for testing, but I trust that Jeff h=
as tested it :-)
>
> Acked-by: St=E9phane Chatty <chatty@enac.fr>

Sorry, but there are some pieces missing.
Please also add the device to the hid_have_special_driver list in
hid-core.c, and add it to the list in Kconfig as well.

Cheers,
Benjamin


>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
